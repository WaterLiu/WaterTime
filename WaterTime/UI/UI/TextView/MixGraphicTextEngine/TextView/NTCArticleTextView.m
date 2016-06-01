//
//  NTCArticleTextView.m
//  TextView
//
//  Created by WaterLiu on 16/06/30.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCArticleTextView.h"
#import "NTCArticleImageAttachmentView.h"
#import "UIImage+Utilities.h"


#define NTCArticleTextView_ImageIndexFile_Name      @"imageIndexFile"
#define NTCArticleTextView_AttributedString_Name    @"AttributedString"


NSString * const DQImageAttachmentViewClose = @"DQImageAttachmentViewClose";


@interface NTCArticleTextView () <NTCArticleImageAttachmentDelegate, NSTextStorageDelegate>


@end

@implementation NTCArticleTextView

- (void)dealloc
{
    _imagePathDic = nil;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    NSTextStorage* textStorage = [[NSTextStorage alloc] init];
    textStorage.delegate = self;    
    NSLayoutManager* layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] init];
    textContainer.widthTracksTextView = YES;
    [layoutManager addTextContainer:textContainer];
    
    if (self = [super initWithFrame:frame textContainer:textContainer])
    {
        _imageViewArray = [NSMutableArray arrayWithCapacity:10];
        _imagePathDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        self.delegate = self;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

}

#pragma mark - Private

- (void)deleteAttachment:(NSRange )range
{
    NSRange deleteRange = range;
    if (range.location > 0)
    {
        /**
         *  找\n前缀
         */
        NSRange __range = NSMakeRange(range.location - 1, 1);
        if (__range.location < [self.textStorage string].length)
        {
            NSString *charater = [[self.textStorage string] substringWithRange:__range];
            if ([charater isEqualToString:@"\n"])
            {
                deleteRange = NSMakeRange(__range.location, deleteRange.length + __range.length);
            }
        }
    }
    /**
     *  \n后缀
     */
    NSRange __range = NSMakeRange(range.location + 1, 1);
    if (__range.location < [self.textStorage string].length)
    {
        NSString *charater = [[self.textStorage string] substringWithRange:__range];
        if ([charater isEqualToString:@"\n"])
        {
            deleteRange = NSMakeRange(deleteRange.location, deleteRange.length + __range.length);
        }
    }
    
    [self.textStorage deleteCharactersInRange:deleteRange];//从textStroage删除
    
    self.selectedRange = NSMakeRange(deleteRange.location, 0);
    
}

- (NSString*)saveImageToDisk:(UIImage*)image withFileName:(NSString*)fileName
{
    if (!image)
    {
        return nil;
    }
    
    NSString* folder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"TextViewImages"];
    if (folder)
    {
        if (![[NSFileManager defaultManager] fileExistsAtPath:folder])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSMutableString* imagePath = [NSMutableString stringWithFormat:@"%@/%@.jpg",folder, fileName];
        NSData* imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:imagePath atomically:YES];
        
        return imagePath;
    }
    else
    {
        return nil;
    }
}

- (void)imageIndexFileSynchronize
{
    if (_imagePathDic)
    {
        NSString* folder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"TextViewImages"];
        if (folder)
        {
            NSMutableString* imageIndexPath = [NSMutableString stringWithFormat:@"%@/%@.plist",folder, NTCArticleTextView_ImageIndexFile_Name];
            [_imagePathDic writeToFile:imageIndexPath atomically:YES];
        }
    }
}

- (UIImage*)thumbnailImage:(UIImage*)image withSize:(CGSize)thumbnailSize
{
    if (!image)
    {
        return nil;
    }
    
    return [image compressToSize:thumbnailSize];
}

- (UIImage*)thumbnailImage:(NSRange)range
{
    NSString* imageFileName = NSStringFromRange(range);
    NSString* folder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"TextViewImages"];
    NSMutableString* imageFilePath = [NSMutableString stringWithFormat:@"%@/thumnailImage_%@.jpg",folder, imageFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imageFilePath])
    {
        NSData* imageData = [NSData dataWithContentsOfFile:imageFilePath];
        UIImage* image = [UIImage imageWithData:imageData];
        return image;
    }
    else
    {
        return nil;
    }
}

- (NSRange)doInsertAttachment:(NSTextAttachment*)attachment
{    
    NSInteger location;
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] init];

    //前插入 \n
    if ([self.textStorage.string length] > 0 && ![[self.textStorage.string substringWithRange:NSMakeRange(self.selectedRange.location - 1, 1)] isEqualToString:@"\n"])
    {
        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    location = self.selectedRange.location + [attributedString length];
    
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    if (self.selectedRange.location >= [self.textStorage length] || ![[self.textStorage.string substringWithRange:NSMakeRange(self.selectedRange.location, 1)] isEqualToString:@"\n"])
    {
        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    [self.textStorage insertAttributedString:attributedString atIndex:self.selectedRange.location];
    
    self.selectedRange = NSMakeRange(self.selectedRange.location + [attributedString length], 0);
    
    return NSMakeRange(location, 1);
}

#pragma mark - Public

- (void)insertImage:(UIImage*)image withDisplaySize:(CGSize)size
{
    UIImage* thumbnailImage = [self thumbnailImage:image withSize:size];
    
    NSTextAttachment* attachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image = [UIImage imageWithSize:image.size withCornerRadius:self.imagesCornerRadius];
    attachment.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    NTCArticleImageAttachmentView* attachmentView = [[NTCArticleImageAttachmentView alloc] initWithImage:thumbnailImage];
    attachmentView.attachment = attachment;
    attachmentView.delegate = self;
    attachmentView.layer.masksToBounds = YES;
    attachmentView.layer.cornerRadius = self.imagesCornerRadius;
    [self addSubview:attachmentView];
    
    NSRange range = [self doInsertAttachment:attachment];
//    [_imageViewCache setObject:attachmentView forKey:[NSValue valueWithRange:range]];
    [_imageViewArray addObject:attachmentView];
    
    CGRect rect = [self.layoutManager boundingRectForGlyphRange:range inTextContainer:self.textContainer];
    CGRect attachmentRect = CGRectOffset(rect, self.textContainerInset.left, self.textContainerInset.top);
    attachmentView.frame = attachmentRect;
}

- (void)synchronizeToDisk
{
//    for (int i = 0; i < [_imageViewArray count]; i++)
//    {
//        NTCArticleImageAttachmentView* view = [_imageViewArray objectAtIndex:i];
//        [self saveImageToDisk:view.image withFileName:[NSString stringWithFormat:@"thumnailImage_%@", NSStringFromRange([(NSValue*)key rangeValue])]];
//    }
//    [self imageIndexFileSynchronize];
//
//    
//    NSString* folder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"TextViewImages"];
//    NSMutableString* imageIndexPath = [NSMutableString stringWithFormat:@"%@/%@",folder, NTCArticleTextView_AttributedString_Name];
//    [NSKeyedArchiver archiveRootObject:self.attributedText toFile:imageIndexPath];
}

- (void)synchronizeToUI
{
    
//    NSArray* views = [_imageViewCache allValues];
//    for (int i = 0; i < [views count]; i++)
//    {
//        UIView* view = [views objectAtIndex:i];
//        if (view.superview)
//        {
//            [view removeFromSuperview];
//        }
//    }
//    
//    [_imagePathDic removeAllObjects];
//    [_imageViewCache removeAllObjects];
//    
//    NSString* folder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"TextViewImages"];
//    NSMutableString* imageIndexPath = [NSMutableString stringWithFormat:@"%@/%@",folder, NTCArticleTextView_AttributedString_Name];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:imageIndexPath])
//    {
//        NSAttributedString* attributedString = [NSKeyedUnarchiver unarchiveObjectWithFile:imageIndexPath];
//        self.attributedText = attributedString;
//    }
}

#pragma mark - NTCArticleImageAttachmentDelegate

- (void)imageAttachmentViewDidClickClose:(NTCArticleImageAttachmentView *)attachmentView
{
    [self.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [self.textStorage length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value && value == attachmentView.attachment)
        {
            [self deleteAttachment:range];
            *stop = YES;
        }
    }];
}

- (void)textStorage:(NSTextStorage *)textStorage didProcessEditing:(NSTextStorageEditActions)editedMask range:(NSRange)editedRange changeInLength:(NSInteger)delta
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (delta < 0)
        {
            NSMutableArray* imageArray = [NSMutableArray arrayWithCapacity:10];
            
            [self.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [self.textStorage length]) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
                for (int i = 0; i < [_imageViewArray count]; i++)
                {
                    NTCArticleImageAttachmentView* view = [_imageViewArray objectAtIndex:i];
                    if (value == view.attachment)
                    {
                        CGRect rect = [self.layoutManager boundingRectForGlyphRange:range inTextContainer:self.textContainer];
                        CGRect attachmentRect = CGRectOffset(rect, self.textContainerInset.left, self.textContainerInset.top);
                        view.frame = attachmentRect;
                        [imageArray addObject:view];
                        
                        break;
                        
                    }
                }
            }];
            
            [_imageViewArray removeObjectsInArray:imageArray];
            
            for (int i = 0; i < [_imageViewArray count]; i++)
            {
                NTCArticleImageAttachmentView* view = [_imageViewArray objectAtIndex:i];
                [view removeFromSuperview];
                view = nil;
            }
            _imageViewArray = imageArray;
        }
    });
}

@end
