//
//  NTCArticleTextView.h
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "EGTextView.h"

FOUNDATION_EXPORT NSString * const DQImageAttachmentViewClose;



@class NTCArticleTextContainer;

@interface NTCArticleTextView : EGTextView

@property (nonatomic, strong) NSMutableDictionary *attachmentDictionary;

- (void)insertAttachmentWithMediaURL:(id)mediaURL imageSize:(CGSize)imageSize;

@end
