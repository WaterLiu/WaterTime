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

- (instancetype)initWithMediaURL:(NSString *)mediaURL imageSize:(CGSize)size{
    if (self = [self init]) {
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
            UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4.0f];
            [path addClip];
            [path fill];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            self.image = image;
        }
    }
}


#pragma mark -
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    return rect;
}

- (NSString *)hashString{
    return @([self hash]).stringValue;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[NSValue valueWithCGSize:self.displaySize] forKey:@"self.displaySize"];
    [aCoder encodeObject:[NSValue valueWithCGSize:self.imageSize] forKey:@"self.imageSize"];
    [aCoder encodeObject:self.mediaURL forKey:@"self.mediaURL"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    self.displaySize = ((NSValue *)[aDecoder decodeObjectForKey:@"self.displaySize"]).CGSizeValue;
    self.imageSize = ((NSValue *)[aDecoder decodeObjectForKey:@"self.imageSize"]).CGSizeValue;
    self.mediaURL = [aDecoder decodeObjectForKey:@"self.mediaURL"];
    return self;
}


@end
