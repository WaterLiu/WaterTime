//
//  NTCArticleImageAttachmentView.m
//  TextView
//
//  Created by NetEase on 15/9/9.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCArticleImageAttachmentView.h"
#import "UIImage+Utilities.h"
#import "AssetHelper.h"


@interface NTCArticleImageAttachmentView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *closeButton;
@end


@implementation NTCArticleImageAttachmentView

- (void)dealloc
{
    
}

- (instancetype)initWithImage:(UIImage*)image
{
    if (self = [super initWithFrame:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height)])
    {
        self.imageView.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        self.imageView.image = image;
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Private

- (void)closeButtonClickAction:(id)sender
{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageAttachmentViewDidClickClose:)])
        {
            [self.delegate imageAttachmentViewDidClickClose:self];
        }
    }];
}

#pragma mark - SET/GET

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (UIButton *)closeButton
{
    if (!_closeButton)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"TextView_ImageDelete_Button"] forState:UIControlStateNormal];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [button addTarget:self action:@selector(closeButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = button;
    }
    return _closeButton;
}


- (UIImage*)image
{
    return self.imageView.image;
}

@end
