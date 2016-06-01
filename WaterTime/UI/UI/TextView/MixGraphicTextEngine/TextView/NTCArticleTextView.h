//
//  NTCArticleTextView.h
//  TextView
//
//  Created by WaterLiu on 16/06/30.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "EGTextView.h"

FOUNDATION_EXPORT NSString * const DQImageAttachmentViewClose;



@class NTCArticleTextContainer;

@interface NTCArticleTextView : EGTextView <UITextViewDelegate>
{
    NSMutableDictionary*    _imagePathDic;
    
    NSMutableArray*         _imageViewArray;
}

// 配置添加的图片的圆角
@property (nonatomic, assign) CGFloat imagesCornerRadius;

@property (nonatomic, assign) CGSize imageDisplaySize;


- (instancetype)initWithFrame:(CGRect)frame;

- (void)insertImage:(UIImage*)image withDisplaySize:(CGSize)size;

- (void)synchronizeToDisk;
- (void)synchronizeToUI;

@end
