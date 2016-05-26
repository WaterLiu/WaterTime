//
//  NTCArticleTextAttachment.h
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTCArticleTextAttachment : NSTextAttachment

@property (nonatomic, assign) CGSize displaySize;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, strong) NSString *mediaURL;

- (instancetype)initWithMediaURL:(NSString *)mediaURL imageSize:(CGSize)size;

- (void)updateContentSize;
- (NSString *)hashString;

@end
