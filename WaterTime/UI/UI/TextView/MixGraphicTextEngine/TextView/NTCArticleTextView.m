//
//  NTCArticleTextView.m
//  TextView
//
//  Created by WaterLiu on 16/06/30.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCArticleTextView.h"
#import "NTCArticleTextStorage.h"
#import "NTCArticleImageAttachmentView.h"
#import "UIImage+Utilities.h"


#define NTCArticleTextView_ImageIndexFile_Name      @"imageIndexFile"
#define NTCArticleTextView_AttributedString_Name    @"AttributedString"


static NSString* const NTCFontObserverName = @"font";
NSString * const DQImageAttachmentViewClose = @"DQImageAttachmentViewClose";


@interface NTCArticleTextView () <NTCArticleTextStorageDelegate, NTCArticleImageAttachmentDelegate>

@property(nonatomic, strong)NTCArticleTextStorage* ss;

@end

@implementation NTCArticleTextView

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NTCFontObserverName];
    
    _imageViewCache = nil;
    _imagePathDic = nil;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    NTCArticleTextStorage* textStorage = [[NTCArticleTextStorage alloc] init];
    NSLayoutManager* layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] init];
    textContainer.widthTracksTextView = YES;
    [layoutManager addTextContainer:textContainer];
    
    if (self = [super initWithFrame:frame textContainer:textContainer])
    {
        textStorage.attachmentDelegate = self;
        [self addObserver:self forKeyPath:NTCFontObserverName options:NSKeyValueObservingOptionNew context:nil];
        
        _imageViewCache = [[NSMutableDictionary alloc] initWithCapacity:10];
        _imagePathDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:NTCFontObserverName])
    {
        UIFont *font = change[NSKeyValueChangeNewKey];
        if (font)
        {
            NTCArticleTextStorage *textStorage = (NTCArticleTextStorage *)self.textStorage;
            NSMutableDictionary *attributes = [textStorage.defaultAttributes mutableCopy];
            [attributes setObject:font forKey:NSFontAttributeName];
            textStorage.defaultAttributes = attributes;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [self.textStorage length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value)
        {
            CGRect rect = [self.layoutManager boundingRectForGlyphRange:range inTextContainer:self.textContainer];
            CGRect attachmentRect = CGRectOffset(rect, self.textContainerInset.left, self.textContainerInset.top);
            NTCArticleImageAttachmentView* view = [_imageViewCache objectForKey:[NSValue valueWithRange:range]];
            view.frame = attachmentRect;
            
            if (view == nil)
            {
                NSLog(@"NILNILNILNILNILNIL");
            }
            
            NSLog(@"rect = %@", NSStringFromCGRect(attachmentRect));
        }
    }];
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
        if ((__range.length+__range.location) <= [self.textStorage string].length)
        {
            NSString *charater = [[self.textStorage string] substringWithRange:__range];
            if ([charater isEqualToString:@"\n"])
            {
                deleteRange = NSMakeRange(deleteRange.location, deleteRange.length+__range.length);
            }
        }
    }
    /**
     *  \n后缀
     */
    NSRange __range = NSMakeRange(deleteRange.location + deleteRange.length, 1);
    if ((__range.length+__range.location) <= [self.textStorage string].length)
    {
        NSString *charater = [[self.textStorage string] substringWithRange:__range];
        if ([charater isEqualToString:@"\n"])
        {
            deleteRange = NSMakeRange(deleteRange.location, deleteRange.length+__range.length);
        }
    }
    [self.textStorage deleteCharactersInRange:deleteRange];//从textStroage删除
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

#pragma mark - Public

- (void)insertImage:(UIImage*)image withDisplaySize:(CGSize)size
{
    UIImage* thumbnailImage = [self thumbnailImage:image withSize:size];
    
    NSTextAttachment* attachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image = [UIImage imageWithSize:image.size withCornerRadius:self.imagesCornerRadius];
    attachment.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
    NSRange selectedRange = self.selectedRange;
    NTCArticleTextStorage *storage = (NTCArticleTextStorage *)self.textStorage;
    
    NTCArticleImageAttachmentView* attachmentView = [[NTCArticleImageAttachmentView alloc] initWithImage:thumbnailImage];
    attachmentView.attachment = attachment;
    attachmentView.delegate = self;
    attachmentView.layer.masksToBounds = YES;
    attachmentView.layer.cornerRadius = self.imagesCornerRadius;
    
    [_imageViewCache setObject:attachmentView forKey:[NSValue valueWithRange:NSMakeRange(selectedRange.location, 1)]];
    
    NSAttributedString *attachmentString = [storage replaceCharactersInRange:selectedRange withTextAttachment:attachment];
    [self setSelectedRange:NSMakeRange(self.selectedRange.location + [attachmentString length] , 0)];
 
    NSString* imagePath = [self saveImageToDisk:image withFileName:NSStringFromRange(NSMakeRange(selectedRange.location + 1, 1))];
    if (imagePath)
    {
        [_imagePathDic setObject:imagePath forKey:[NSString stringWithFormat:@"%ld", [attachment hash]]];
    }
}

- (void)synchronizeToDisk
{
    NSArray* keys = [_imageViewCache allKeys];
    for (int i = 0; i < [keys count]; i++)
    {
        id key = [keys objectAtIndex:i];
        NTCArticleImageAttachmentView* view = [_imageViewCache objectForKey:key];
        [self saveImageToDisk:view.image withFileName:[NSString stringWithFormat:@"thumnailImage_%@", NSStringFromRange([(NSValue*)key rangeValue])]];
    }
    [self imageIndexFileSynchronize];

    
    NSString* folder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"TextViewImages"];
    NSMutableString* imageIndexPath = [NSMutableString stringWithFormat:@"%@/%@",folder, NTCArticleTextView_AttributedString_Name];
    [NSKeyedArchiver archiveRootObject:self.attributedText toFile:imageIndexPath];
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

#pragma mark - NTCArticleTextStorageDelegate

- (void)textStroage:(NSTextStorage*)textStorage willAddAttachment:(NSTextAttachment*)attachment atTextRange:(NSRange)range
{
    NTCArticleImageAttachmentView* attachmentView = [_imageViewCache objectForKey:[NSValue valueWithRange:range]];
    if (attachmentView != nil)
    {
        attachment.bounds = CGRectMake(0.0f, 0.0f, attachmentView.image.size.width, attachmentView.image.size.height);
        [self addSubview:attachmentView];
    }
    else
    {
        UIImage* thumbnailImage = [self thumbnailImage:range];
        
        NTCArticleImageAttachmentView* attachmentView = [[NTCArticleImageAttachmentView alloc] initWithImage:thumbnailImage];
        attachmentView.attachment = attachment;
        attachmentView.delegate = self;
        attachmentView.layer.masksToBounds = YES;
        attachmentView.layer.cornerRadius = self.imagesCornerRadius;
        attachmentView.attachment.image = thumbnailImage;
        [_imageViewCache setObject:attachmentView forKey:[NSValue valueWithRange:range]];
        
        
        attachment.bounds = CGRectMake(0.0f, 0.0f, thumbnailImage.size.width, thumbnailImage.size.height);
    }
}

- (void)textStroage:(NSTextStorage*)textStorage willRemove:(NSTextAttachment*)attachment atTextRange:(NSRange)range
{
    NTCArticleAttachmentView* attachmentView =[_imageViewCache objectForKey:[NSValue valueWithRange:range]];
    if (attachmentView)
    {
        [attachmentView removeFromSuperview];
        [_imageViewCache removeObjectForKey:[NSValue valueWithRange:range]];
        attachmentView = nil;
    }
}

- (void)textStroage:(NSTextStorage*)textStorage didRemove:(NSTextAttachment*)attachment atTextRange:(NSRange)range
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DQImageAttachmentViewClose object:nil]; 
}

@end
