//
//  NTCArticleImageAttachmentView.m
//  TextView
//
//  Created by NetEase on 15/9/9.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCArticleImageAttachmentView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Compress.h"
#import "AssetHelper.h"

static NSString *const NTCArticleAttachmentImageSizeName = @"imageSize";
static NSString *const NTCArticleAttachmentMediaURLName = @"mediaURL";

@interface NTCArticleImageAttachmentView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *closeButton;
@end


@implementation NTCArticleImageAttachmentView

- (void)dealloc{
    [self removeObserver:self forKeyPath:NTCArticleAttachmentMediaURLName];
    [self removeObserver:self forKeyPath:NTCArticleAttachmentImageSizeName];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addObserver:self forKeyPath:NTCArticleAttachmentMediaURLName options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:NTCArticleAttachmentImageSizeName options:NSKeyValueObservingOptionNew context:NULL];
        [self addSubview:self.imageView];
        [self addSubview:self.closeButton];
        
        self.imageView.alpha = 0.0;
        self.closeButton.alpha = 0.0;
        
        self.layer.cornerRadius = 4.0f;
        self.imageView.layer.cornerRadius = 4.0f;
        self.imageView.layer.masksToBounds = YES;

    }
    return self;
}

- (instancetype)initWithMediaURL:(NSString *)mediaURL imageSize:(CGSize)size{
    if (self = [self initWithFrame:CGRectZero])
    {
        self.mediaURL = mediaURL;
        self.imageSize = size;
    }
    return self;
}

- (void)setAnimatedImage:(UIImage *)image
{
    self.imageView.image = image;
    self.imageView.alpha = 0.0;
    self.closeButton.alpha = 0.3;
    [UIView animateWithDuration:0.3 delay:.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.imageView.alpha = 1.0;
        self.closeButton.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:NTCArticleAttachmentMediaURLName]) {
        id url = change[NSKeyValueChangeNewKey];
        if (url) {
            [[AssetHelper sharedAssetHelper].assetsLibrary assetForURL:[NSURL URLWithString:url] resultBlock:^(ALAsset *asset) {
                //                UIImage *image = [UIImage imageWithCGImage:[asset thumbnail]];
                ALAssetRepresentation* representation = [asset defaultRepresentation];
                @autoreleasepool {
                    UIImage* image = [UIImage imageWithCGImage:[representation fullResolutionImage]];
                    [image compressToSize:self.imageSize complection:^(UIImage* newImage) {
                        newImage = [newImage adjustOrientation:representation.orientation];
                        [self performSelector:@selector(setAnimatedImage:) withObject:newImage afterDelay:.0 inModes:@[NSDefaultRunLoopMode]];
                    }];
                }
            } failureBlock:^(NSError *error) {
                
            }];
        }
        else
        {
            self.imageView.image = nil;
        }
    }
    if ([keyPath isEqualToString:NTCArticleAttachmentImageSizeName]) {
        id value = change[NSKeyValueChangeNewKey];
        if (value) {
            CGSize size = [value CGSizeValue];
            _imageSize = size;
        }else{
            _imageSize = CGSizeMake(0, 0);
        }
        [self layoutSubviews];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, _imageSize.width, _imageSize.height);
    self.closeButton.frame = CGRectMake(_imageSize.width - 33, 3, 30, 30);
}

- (void)closeButtonClickAction:(id)sender{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageAttachmentViewDidClickClose:)]) {
            [self.delegate imageAttachmentViewDidClickClose:self];
        }
    }];
}

#pragma mark - SET/GET
- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView = imageView;
    }
    return _imageView;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"imageDelete"] forState:UIControlStateNormal];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [button addTarget:self action:@selector(closeButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = button;
    }
    return _closeButton;
}



#pragma mark - Utils

- (UIImage *)fixOrientation:(UIImage *)aImage withOrientation:(UIImageOrientation)orientation {
    
    // No-op if the orientation is already correct
    if (orientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (orientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (orientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
