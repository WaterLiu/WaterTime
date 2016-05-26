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

@interface NTCArticleTextView () <NTCArticleTextStorageDelegate, NTCArticleImageAttachmentDelegate>

@end

@implementation NTCArticleTextView

- (void)dealloc{
    [self removeObserver:self forKeyPath:NTCFontObserverName];
}

- (instancetype)initArticleTextContainerWithFrame:(CGRect)frame{
    NTCArticleTextStorage *textStorage = [[NTCArticleTextStorage alloc]init];
    NTCArticleLayoutManager *layoutManager = [[NTCArticleLayoutManager alloc]init];
    [textStorage addLayoutManager:layoutManager];
    NTCArticleTextContainer *textContainer = [[NTCArticleTextContainer alloc]initWithSize:frame.size];
    textContainer.widthTracksTextView = YES;
    [layoutManager addTextContainer:textContainer];
    
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        textStorage.attachmentDelegate = self;
        self.attachmentDictionary = [@{} mutableCopy];

        [self addObserver:self forKeyPath:NTCFontObserverName options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:NTCFontObserverName]) {
        UIFont *font = change[NSKeyValueChangeNewKey];
        if (font) {
            NTCArticleTextStorage *textStorage = (NTCArticleTextStorage *)self.textStorage;
            NSMutableDictionary *attributes = [textStorage.defaultAttributes mutableCopy];
            [attributes setObject:font forKey:NSFontAttributeName];
            
            textStorage.defaultAttributes = attributes;
        }
    }
}

- (void)insertAttachmentWithMediaURL:(id)mediaURL imageSize:(CGSize)imageSize{
    NSString *url = [mediaURL isKindOfClass:[NSURL class]] ? [mediaURL absoluteString] : mediaURL;
    
    NTCArticleTextAttachment *attachment = [[NTCArticleTextAttachment alloc]initWithMediaURL:url imageSize:imageSize];
//    attachment.displaySize = CGSizeMake(self.textContainer.size.width - self.textContainer.lineFragmentPadding * 2.0f, imageSize.height);
    attachment.displaySize = imageSize;
    [attachment updateContentSize];
    
    NSRange selectedRange = self.selectedRange;
    NTCArticleTextStorage *storage = (NTCArticleTextStorage *)self.textStorage;
    NSAttributedString *attachmentString = [storage replaceCharactersInRange:selectedRange withTextAttachment:attachment];
    
    [self setSelectedRange:NSMakeRange(self.selectedRange.location + [attachmentString length] , 0)];
}

- (void)layoutSubviews{
    __block NSInteger index = 0;
    [self.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [self.textStorage length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value) {
            CGRect rect = [self.layoutManager boundingRectForGlyphRange:range inTextContainer:self.textContainer];
            CGRect attachmentRect = CGRectOffset(rect, self.textContainerInset.left, self.textContainerInset.top);
            NTCArticleImageAttachmentView *view = [self.attachmentDictionary objectForKey:[value hashString]];
            view.frame = attachmentRect;
            index += 1;
        }
    }];
    
    [super layoutSubviews];
}

#pragma mark - NTCArticleImageAttachmentDelegate
- (void)imageAttachmentViewDidClickClose:(NTCArticleImageAttachmentView *)attachmentView{
    [self.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [self.textStorage length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value && value == attachmentView.attachment) {
            NSRange deleteRange = range;
            [self.textStorage deleteCharactersInRange:deleteRange];//从textStroage删除
            *stop = YES;
        }
    }];
}

#pragma mark - NTCArticleTextStorageDelegate
- (void)textStroage:(NSTextStorage *)textStorage willAddAttachment:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range{
    NTCArticleImageAttachmentView *view = [[NTCArticleImageAttachmentView alloc]initWithMediaURL:attachment.mediaURL imageSize:attachment.imageSize];
    view.attachment = attachment;
    view.delegate = self;
    [self addSubview:view];
    [self.attachmentDictionary setObject:view forKey:[attachment hashString]];
}

- (void)textStroage:(NSTextStorage *)textStorage willRemove:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range{
    [self deleteAttachmentForKey:[attachment hashString]];
}

- (void)deleteAttachmentForKey:(NSString *)key{
    NTCArticleAttachmentView *view =[self.attachmentDictionary objectForKey:key];
    if (view) {
        [view removeFromSuperview];
        [self.attachmentDictionary removeObjectForKey:key];
        view = nil;
    }
}

@end





/**
 *  获取当前可视文本范围
 *
 *  @param layoutManager
 *  @param textContainer
 *
 *  @return NSRange
 */
/*
 - (NSRange)rangeOfVisualText:(NSLayoutManager *)layoutManager textContainer:(NSTextContainer *)textContainer{
 CGRect visualRect = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.frame.size.width, self.frame.size.height);
 NSRange range = [layoutManager glyphRangeForBoundingRect:visualRect inTextContainer:textContainer];
 
 return range;
 }
 */
/*
 - (void)layoutImageAttachmentsForTextRange:(NSRange)textRange textStorage:(NSTextStorage *)textStroage layoutManager:(NSLayoutManager *)layoutManager textContainer:(NSTextContainer *)textContainer{
 NSMutableArray *attachments = [@[] mutableCopy];
 
 [textStroage enumerateAttribute:NSAttachmentAttributeName inRange:textRange options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
 if (value) {
 //命中一个attachment
 CGRect attachmentRect = [layoutManager boundingRectForGlyphRange:range inTextContainer:textContainer];
 CGRect attachmentFrame = attachmentRect;
 
 [attachments addObject:@{@"attachment" : value,
 @"frame" : [NSValue valueWithCGRect:attachmentFrame]}];
 
 //            [self drawAttachmentViewWithAttachments:attachments];
 }
 }];
 }
 */

/*
 - (void)drawAttachmentViewWithAttachments:(NSArray *)attachments{
 [self.reusableAttachmentViews addObjectsFromArray:self.visibleAttachmentViews];
 [self.visibleAttachmentViews removeAllObjects];
 
 [attachments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
 NTCArticleAttachmentView *view = [self dequeueResuableImageAttachment:@"aa"];
 if (!view) {
 view = [[NTCArticleAttachmentView alloc]initWithFrame:CGRectZero];
 view.reuseIdentifier = @"aa";
 [view.layer setBorderWidth:3];
 [view.layer setBorderColor:[[UIColor purpleColor] CGColor]];
 [self addSubview:view];
 [self.visibleAttachmentViews addObject:view];
 }
 
 view.frame = [obj[@"frame"] CGRectValue];
 }];
 }
 */

/*
 - (NTCArticleAttachmentView *)dequeueResuableImageAttachment:(NSString *)identifier{
 NTCArticleAttachmentView *view = [self.reusableAttachmentViews anyObject];
 if (view && [view.reuseIdentifier isEqualToString:identifier]) {
 [self.reusableAttachmentViews removeObject:view];
 
 return view;
 }
 
 return nil;
 }
 */
