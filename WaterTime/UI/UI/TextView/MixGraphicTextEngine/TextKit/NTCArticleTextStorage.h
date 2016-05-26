//
//  NTCArticleTextStorage.h
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTCArticleTextAttachment.h"

@protocol NTCArticleTextStorageDelegate;

@interface NTCArticleTextStorage : NSTextStorage

@property (nonatomic, strong) NSDictionary *defaultAttributes;
@property (nonatomic, weak)   id <NTCArticleTextStorageDelegate> attachmentDelegate;

- (NSAttributedString *)replaceCharactersInRange:(NSRange)range withTextAttachment:(NTCArticleTextAttachment *)attachment;

@end


@protocol NTCArticleTextStorageDelegate <NSObject>

@optional

- (void)textStroage:(NSTextStorage *)textStorage willAddAttachment:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range;
- (void)textStroage:(NSTextStorage *)textStorage didAddAttachment:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range;

- (void)textStroage:(NSTextStorage *)textStorage willRemove:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range;
- (void)textStroage:(NSTextStorage *)textStorage didRemove:(NTCArticleTextAttachment *)attachment atTextRange:(NSRange)range;

@end
