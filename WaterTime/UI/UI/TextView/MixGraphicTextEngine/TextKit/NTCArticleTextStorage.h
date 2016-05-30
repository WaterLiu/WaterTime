//
//  NTCArticleTextStorage.h
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NTCArticleTextStorageDelegate <NSObject>
@optional

- (void)textStroage:(NSTextStorage*)textStorage willAddAttachment:(NSTextAttachment*)attachment atTextRange:(NSRange)range;
- (void)textStroage:(NSTextStorage*)textStorage didAddAttachment:(NSTextAttachment*)attachment atTextRange:(NSRange)range;
- (void)textStroage:(NSTextStorage*)textStorage willRemove:(NSTextAttachment*)attachment atTextRange:(NSRange)range;
- (void)textStroage:(NSTextStorage*)textStorage didRemove:(NSTextAttachment*)attachment atTextRange:(NSRange)range;

@end


@protocol NTCArticleTextStorageDelegate;

@interface NTCArticleTextStorage : NSTextStorage

@property (nonatomic, strong) NSDictionary *defaultAttributes;
@property (nonatomic, weak) id <NTCArticleTextStorageDelegate> attachmentDelegate;

- (NSAttributedString *)replaceCharactersInRange:(NSRange)range withTextAttachment:(NSTextAttachment*)attachment;

@end

