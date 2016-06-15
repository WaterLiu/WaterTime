//
//  NTCPostLongArticleTextView.m
//  NeteaseCoffee
//
//  Created by NetEase on 15-9-10.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCPostLongArticleTextView.h"
#import "NTCArticleTextStorage.h"

@implementation NTCPostLongArticleTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 8.5f;// 字体的行间距
        [(NTCArticleTextStorage *)self.textStorage setDefaultAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0],
                                                                          NSForegroundColorAttributeName : [UIColor blackColor],
                                                                          NSParagraphStyleAttributeName : paragraphStyle
                                                                          }];
        
    }
    return self;
}


//- (void)insertAttachmentWithMediaURL:(id)mediaURL autoScaleImageOriginalSize:(CGSize)imageSize{
//    CGFloat maxiumWidth = self.textContainer.size.width - self.textContainer.lineFragmentPadding * 2.0f;
//    CGFloat miniumWidth = 75.0f;
//    CGSize size = imageSize;
//    //需要压缩或扩大的width
//    if (imageSize.width > maxiumWidth || imageSize.width < miniumWidth)
//    {
//        CGFloat width = maxiumWidth;
//        CGFloat height = maxiumWidth / imageSize.width * imageSize.height;
//        size = CGSizeMake(width, height);
//    }
//    [self insertAttachmentWithMediaURL:mediaURL imageSize:size];
//}



@end
