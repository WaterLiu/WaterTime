//
//  UIImage+SizeTool.m
//  TextView
//
//  Created by NetEase on 15/9/2.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "UIImage+Compress.h"

NSString *const UIImageCompressHorizontalAlignmentAttributeName = @"NSContentHorizontalAlignmentAttributeName";
NSString *const UIImageCompressVerticalAlignmentAttributeName = @"NSControlContentVerticalAlignmentAttributeName";

@implementation UIImage (Compress)

- (void)compressToSize:(CGSize)size complection:(void (^) (UIImage *))complection{
    if (self.size.width <= size.width && self.size.height <= size.height) {
        if (complection) {
            complection(self);
        }
        return;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        UIGraphicsBeginImageContext(size);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if(complection){ complection(newImage); }
        });
    });
}

- (UIImage *)compressToSize:(CGSize)size{
    if (self.size.width <= size.width && self.size.height <= size.height) {
        return nil;
    }
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)compressToSize:(CGSize)size fillSize:(CGSize)fillSize attributes:(NSDictionary *)attributes{
    UIControlContentHorizontalAlignment horizontalAlignment = [attributes objectForKey:UIImageCompressHorizontalAlignmentAttributeName]
    ? [[attributes objectForKey:UIImageCompressHorizontalAlignmentAttributeName] intValue] : UIControlContentHorizontalAlignmentLeft;
    UIControlContentVerticalAlignment verticalAlignment = [attributes objectForKey:UIImageCompressVerticalAlignmentAttributeName]
    ? [[attributes objectForKey:UIImageCompressVerticalAlignmentAttributeName] intValue] : UIControlContentVerticalAlignmentCenter;
    UIImage *compressedImage = [self compressToSize:size];
    
    CGPoint _origin = CGPointZero;
    CGSize  _size   = compressedImage.size;
    
    switch (horizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
        {
            _origin.x = 0.0f;
        }
            break;
        case UIControlContentHorizontalAlignmentCenter:
        {
            _origin.x = (fillSize.width - size.width) / 2.0f;
        }
            break;
        case UIControlContentHorizontalAlignmentRight:
        {
            _origin.x = fillSize.width - size.width;
        }
            break;
        case UIControlContentHorizontalAlignmentFill:
        {
            _origin.x = 0.0f;
            _size.width = fillSize.width;
        }
            break;
    }
    
    switch (verticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
        {
            _origin.y = 0.0f;
        }
            break;
        case UIControlContentVerticalAlignmentCenter:
        {
            _origin.y = (fillSize.height - size.height) / 2.0f;
        }
            break;
        case UIControlContentVerticalAlignmentBottom:
        {
            _origin.y = fillSize.height - size.height;
        }
            break;
        case UIControlContentVerticalAlignmentFill:
        {
            _origin.y = 0.0f;
            _size.height = fillSize.height;
        }
            break;
    }
    
    CGRect rect = CGRectMake(_origin.x, _origin.y, _size.width, _size.height);
    UIGraphicsBeginImageContext(fillSize);
    [compressedImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)compressToSize:(CGSize)size fillSize:(CGSize)fillSize attributes:(NSDictionary *)attributes complection:(void (^) (UIImage *))complection{
    
    UIControlContentHorizontalAlignment horizontalAlignment = [attributes objectForKey:UIImageCompressHorizontalAlignmentAttributeName]
    ? [[attributes objectForKey:UIImageCompressHorizontalAlignmentAttributeName] intValue] : UIControlContentHorizontalAlignmentLeft;
    UIControlContentVerticalAlignment verticalAlignment = [attributes objectForKey:UIImageCompressVerticalAlignmentAttributeName]
    ? [[attributes objectForKey:UIImageCompressVerticalAlignmentAttributeName] intValue] : UIControlContentVerticalAlignmentCenter;
    
    [self compressToSize:size complection:^(UIImage *compressedImage) {
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        dispatch_async(queue, ^{
            CGPoint _origin = CGPointZero;
            CGSize  _size   = compressedImage.size;
            
            switch (horizontalAlignment) {
                case UIControlContentHorizontalAlignmentLeft:
                {
                    _origin.x = 0.0f;
                }
                    break;
                case UIControlContentHorizontalAlignmentCenter:
                {
                    _origin.x = (fillSize.width - size.width) / 2.0f;
                }
                    break;
                case UIControlContentHorizontalAlignmentRight:
                {
                    _origin.x = fillSize.width - size.width;
                }
                    break;
                case UIControlContentHorizontalAlignmentFill:
                {
                    _origin.x = 0.0f;
                    _size.width = fillSize.width;
                }
                    break;
            }
            
            switch (verticalAlignment) {
                case UIControlContentVerticalAlignmentTop:
                {
                    _origin.y = 0.0f;
                }
                    break;
                case UIControlContentVerticalAlignmentCenter:
                {
                    _origin.y = (fillSize.height - size.height) / 2.0f;
                }
                    break;
                case UIControlContentVerticalAlignmentBottom:
                {
                    _origin.y = fillSize.height - size.height;
                }
                    break;
                case UIControlContentVerticalAlignmentFill:
                {
                    _origin.y = 0.0f;
                    _size.height = fillSize.height;
                }
                    break;
            }
            
            CGRect rect = CGRectMake(_origin.x, _origin.y, _size.width, _size.height);
            UIGraphicsBeginImageContext(fillSize);
            [compressedImage drawInRect:rect];
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            dispatch_async(dispatch_get_main_queue(), ^{
                if(complection){ complection(newImage); }
            });
        });
    }];
}

- (void)compressedToFixableWidth:(CGFloat)fixableWidth verticalSpacing:(CGFloat)verticalSpacing complection:(void (^) (UIImage *))complection{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        @autoreleasepool {
            CGFloat heightSpacing   = 10.0f;
            CGSize compressSize     = CGSizeZero;
            CGSize acseptSize       = CGSizeZero;
            CGSize size             = self.size;
            if (size.width < fixableWidth)
            {
                compressSize        = size;
                acseptSize.width    = fixableWidth;
                acseptSize.height   = size.height + heightSpacing * 2.0f;
            }
            else
            {
                compressSize.width  = fixableWidth;
                compressSize.height = fixableWidth * size.height / size.width;
                acseptSize.width    = fixableWidth;
                acseptSize.height   = compressSize.height + heightSpacing * 2.0f;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self compressToSize:compressSize fillSize:acseptSize attributes:nil complection:complection];
            });
        }
    });
}

- (void)compressedToFixableWidth:(CGFloat)fixableWidth verticalSpacing:(CGFloat)verticalSpacing closeImage:(UIImage *)closeImage complection:(void (^) (UIImage *compressedImage, CGRect imageRect, CGRect closeImageRect))complection{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        @autoreleasepool {
            CGFloat heightSpacing   = 10.0f;
            CGSize compressSize     = CGSizeZero;
            CGSize acseptSize       = CGSizeZero;
            CGSize size             = self.size;
            CGSize closeSize        = closeImage.size;
            if (size.width < fixableWidth)
            {
                compressSize        = size;
                acseptSize.width    = fixableWidth;
                acseptSize.height   = size.height + heightSpacing * 2.0f;
            }
            else
            {
                compressSize.width  = fixableWidth;
                compressSize.height = fixableWidth * size.height / size.width;
                acseptSize.width    = fixableWidth;
                acseptSize.height   = compressSize.height + heightSpacing * 2.0f;
            }
            
            CGRect imageRect = CGRectMake(0, 10.0f, compressSize.width, compressSize.height);
            CGRect closeImageRect = CGRectMake(compressSize.width - closeSize.width - 3.0f, 10.0f + 3.0f, closeSize.width, closeSize.height);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self compressToSize:compressSize fillSize:acseptSize attributes:nil complection:^(UIImage *compressImage) {
                    UIGraphicsBeginImageContext(compressImage.size);
                    [compressImage drawInRect:CGRectMake(0, 0, compressImage.size.width, compressImage.size.height)];
                    [closeImage drawInRect:closeImageRect];
                    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                    
                    UIGraphicsEndImageContext();
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(complection){ complection(newImage, imageRect, closeImageRect); }
                    });
                }];
            });
        }
    });
}



@end
