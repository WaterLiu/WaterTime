//
//  NTCArticleTextView.h
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "EGTextView.h"

@interface NTCArticleTextView : EGTextView

@property (nonatomic, strong) NSMutableDictionary *attachmentDictionary;

- (instancetype)initArticleTextContainerWithFrame:(CGRect)frame;

- (void)insertAttachmentWithMediaURL:(id)mediaURL imageSize:(CGSize)imageSize;

@end
