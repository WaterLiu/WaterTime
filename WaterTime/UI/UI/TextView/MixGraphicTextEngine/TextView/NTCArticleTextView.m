//
//  NTCArticleTextView.m
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCArticleTextView.h"
#import "NTCArticleTextStorage.h"
#import "NTCArticleLayoutManager.h"
#import "NTCArticleTextContainer.h"

#import "NTCArticleTextAttachment.h"
#import "NTCArticleImageAttachmentView.h"

static NSString* const NTCFontObserverName = @"font";
NSString * const DQImageAttachmentViewClose = @"DQImageAttachmentViewClose";


@interface NTCArticleTextView () <NTCArticleTextStorageDelegate, NTCArticleImageAttachmentDelegate>

@end

@implementation NTCArticleTextView

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NTCFontObserverName];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8.5f;// 字体的行间距
    [(NTCArticleTextStorage *)self.textStorage setDefaultAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0],
                                                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                                                      NSParagraphStyleAttributeName : paragraphStyle
                                                                      }];
    
    
    
    
    NTCArticleTextStorage *textStorage = [[NTCArticleTextStorage alloc]init];
    NTCArticleLayoutManager *layoutManager = [[NTCArticleLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NTCArticleTextContainer *textContainer = [[NTCArticleTextContainer alloc] initWithSize:frame.size];
    textContainer.widthTracksTextView = YES;
    [layoutManager addTextContainer:textContainer];
    
    if (self = [super initWithFrame:frame textContainer:textContainer])
    {
        _imageViewCache = [[NSMutableDictionary alloc] initWithCapacity:10];
        textStorage.attachmentDelegate = self;
        [self addObserver:self forKeyPath:NTCFontObserverName options:NSKeyValueObservingOptionNew context:nil];
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
    [self.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [self.textStorage length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value)
        {
            CGRect rect = [self.layoutManager boundingRectForGlyphRange:range inTextContainer:self.textContainer];
            CGRect attachmentRect = CGRectOffset(rect, self.textContainerInset.left, self.textContainerInset.top);
            NTCArticleImageAttachmentView* view = [_imageViewCache objectForKey:[value hashString]];
            view.frame = attachmentRect;
        }
    }];
    
    [super layoutSubviews];
}


#pragma mark - Private

- (void)deleteAttachment:(NSRange )range
{
    NSRange deleteRange = range;
    if (range.location > 0) {
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

#pragma mark - Public

- (void)insertImage:(UIImage*)image
{
    NTCArticleTextAttachment* attachment = [[NTCArticleTextAttachment alloc] initWithImageSize:image.size];
    NSRange selectedRange = self.selectedRange;
    NTCArticleTextStorage *storage = (NTCArticleTextStorage *)self.textStorage;
    
    NTCArticleImageAttachmentView* attachmentView = [[NTCArticleImageAttachmentView alloc] initWithImage:image];
    attachmentView.attachment = attachment;
    attachmentView.delegate = self;
    attachmentView.layer.masksToBounds = YES;
    attachmentView.layer.cornerRadius = self.imagesCornerRadius;
    
    [_imageViewCache setObject:attachmentView forKey:[attachment hashString]];
    
    NSAttributedString *attachmentString = [storage replaceCharactersInRange:selectedRange withTextAttachment:attachment];
    [self setSelectedRange:NSMakeRange(self.selectedRange.location + [attachmentString length] , 0)];
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

- (void)textStroage:(NSTextStorage *)textStorage willAddAttachment:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range
{
    NTCArticleImageAttachmentView* attachmentView = [_imageViewCache objectForKey:[attachment hashString]];
    if (attachmentView != nil)
    {
        [self addSubview:attachmentView];
        [attachmentView setNeedsLayout];
    }
}

- (void)textStroage:(NSTextStorage *)textStorage willRemove:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range
{
    NTCArticleAttachmentView* attachmentView =[_imageViewCache objectForKey:[attachment hashString]];
    if (attachmentView)
    {
        [attachmentView removeFromSuperview];
        [_imageViewCache removeObjectForKey:[attachment hashString]];
        attachmentView = nil;
    }
}

- (void)textStroage:(NSTextStorage *)textStorage didRemove:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DQImageAttachmentViewClose object:nil]; 
}

@end
