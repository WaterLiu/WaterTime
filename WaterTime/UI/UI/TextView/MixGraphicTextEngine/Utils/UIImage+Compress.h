//
//  UIImage+SizeTool.h
//  TextView
//
//  Created by NetEase on 15/9/2.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const UIImageCompressHorizontalAlignmentAttributeName;
UIKIT_EXTERN NSString *const UIImageCompressVerticalAlignmentAttributeName;

@interface UIImage (Compress)

/**
 *  压缩图片到指定大小
 *
 *  @param size
 *  @param complection
 */
- (UIImage *)compressToSize:(CGSize)size;

- (void)compressToSize:(CGSize)size complection:(void (^) (UIImage *))complection;

/**
 *  压缩图片到指定大小，并设置fill区域
 *
 *  @param size
 *  @param fillSize
 *  @param attributes  图片布局设置 UIImageCompressHorizontalAlignmentAttributeName, UIImageCompressVerticalAlignmentAttributeName
 *  @param complection
 */
- (UIImage *)compressToSize:(CGSize)size fillSize:(CGSize)fillSize attributes:(NSDictionary *)attributes;
- (void)compressToSize:(CGSize)size fillSize:(CGSize)fillSize attributes:(NSDictionary *)attributes complection:(void (^) (UIImage *))complection;

/**
 *  UIImage 旋转
 *
 *  @param orientation 方向
 */

- (UIImage *)adjustOrientation:(UIImageOrientation)orientation;

- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;

@end
