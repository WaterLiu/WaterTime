//
//  NTCArticleTextAttachment.m
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCArticleTextAttachment.h"

static NSString *const NTCArticleTextAttachmentBoundsName = @"bounds";

@implementation NTCArticleTextAttachment

- (void)dealloc{
    [self removeObserver:self forKeyPath:NTCArticleTextAttachmentBoundsName];
}

- (instancetype)initWithMediaURL:(NSString *)mediaURL imageSize:(CGSize)size{
    if (self = [self init]) {
        [self addObserver:self forKeyPath:NTCArticleTextAttachmentBoundsName options:NSKeyValueObservingOptionNew context:NULL];
        self.imageSize          = size;
        self.displaySize        = size;
        self.mediaURL           = mediaURL;
    }
    return self;
}

- (void)updateContentSize{
    self.bounds = CGRectMake(0, 0, _displaySize.width, _displaySize.height);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:NTCArticleTextAttachmentBoundsName]) {
        NSValue *value = change[NSKeyValueChangeNewKey];
        if (value) {
            CGRect rect = [value CGRectValue];
            UIGraphicsBeginImageContext(rect.size);
            [[UIColor colorWithWhite:225.0/255.0 alpha:1.0] setFill];
            UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            self.image = image;
        }
    }
}


#pragma mark -
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    UIImage *image = self.image;
    CGSize size = image.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    return rect;
}

- (NSString *)hashString{
    return @([self hash]).stringValue;
}


@end
