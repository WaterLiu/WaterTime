//
//  NTCArticleTextAttachment.h
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTCArticleTextAttachment : NSTextAttachment
{
    CGSize  _imageSize;
}

@property (nonatomic, assign) CGFloat cornerRadius;         //占位图圆角


- (instancetype)initWithImageSize:(CGSize)size;

- (NSString *)hashString;

@end
