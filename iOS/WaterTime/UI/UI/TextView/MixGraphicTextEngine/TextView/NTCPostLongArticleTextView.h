//
//  NTCPostLongArticleTextView.h
//  NeteaseCoffee
//
//  Created by lihao on 15-9-10.
//  Copyright (c) 2015年 com.netease. All rights reserved.
//

#import "NTCArticleTextView.h"

@interface NTCPostLongArticleTextView : NTCArticleTextView

- (void)insertAttachmentWithMediaURL:(id)mediaURL autoScaleImageOriginalSize:(CGSize)imageSize;

- (void)insertAttachmentWithImage:(UIImage *)image;

@end
