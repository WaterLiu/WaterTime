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

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NTCArticleTextAttachmentBoundsName];
    
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addObserver:self forKeyPath:NTCArticleTextAttachmentBoundsName options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (instancetype)initWithImageSize:(CGSize)size
{
    if (self = [self init])
    {
        self.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
    }
    return self;
}

#pragma mark - Private

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NTCArticleTextAttachmentBoundsName])
    {
        NSValue *value = change[NSKeyValueChangeNewKey];
        if (value)
        {
            CGRect rect = [value CGRectValue];
            UIGraphicsBeginImageContext(rect.size);
            [[UIColor colorWithWhite:225.0/255.0 alpha:1.0] setFill];
            UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
            [path addClip];
            [path fill];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            self.image = image;
        }
    }
}

#pragma mark - NSTextAttachment Override

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.height);
    return rect;
}

- (NSString *)hashString
{
    return @([self hash]).stringValue;
}

@end
