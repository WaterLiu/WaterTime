//
//  NTCArticleTextStorage.m
//  TextView
//
//  Created by NetEase on 15/9/8.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCArticleTextStorage.h"

@interface NTCArticleTextStorage ()
{
    NSMutableAttributedString *_imp;
}
@end

@implementation NTCArticleTextStorage

- (instancetype)init
{
    if (self = [super init])
    {
        _imp = [NSMutableAttributedString new];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineSpacing = 10.0f;// 字体的行间距
        self.defaultAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                                   NSForegroundColorAttributeName : [UIColor blackColor],
                                   NSParagraphStyleAttributeName : paragraphStyle
                                   };
    }
    return self;
}

#pragma mark - Reading Text
- (NSString *)string
{
    return [_imp string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_imp attributesAtIndex:location effectiveRange:range];
}

- (NSAttributedString *)replaceCharactersInRange:(NSRange)range withTextAttachment:(NSTextAttachment*)attachment
{
    NSRange _range = NSMakeRange(0, [_imp length]);
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];

    //校验前缀/n
    if (range.location > 0)
    {
        NSRange __range = NSMakeRange(range.location - 1, 1);
        unichar attachmentChar = NSAttachmentCharacter;
        NSString *attachmentString = [NSString stringWithCharacters:&attachmentChar length:1];
        NSString *charater = [[_imp string] substringWithRange:__range];
        if (![charater isEqualToString:attachmentString] && ![charater isEqualToString:@"\n"])
        {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
    }
    
    [string appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    //校验后缀/n
    if (range.location + range.length < _range.length)
    {
        NSRange __range = NSMakeRange(range.location + range.length, 1);
        unichar attachmentChar = NSAttachmentCharacter;
        NSString *attachmentString = [NSString stringWithCharacters:&attachmentChar length:1];
        NSString *charater = [[_imp string] substringWithRange:__range];
        if (![charater isEqualToString:attachmentString] && ![charater isEqualToString:@"\n"])
        {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
    }
    else
    {
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    [self replaceCharactersInRange:range withAttributedString:string];
    
    return string;
}

- (void)removeAttribute:(NSString *)name range:(NSRange)range
{
    
}

- (void)replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString
{
    if ([attrString length])
    {
        NSMutableAttributedString *string = [attrString mutableCopy];
        [string addAttributes:self.defaultAttributes range:NSMakeRange(0, [attrString length])];
        attrString = string;
    }
    
    //便利即将加入的attrString,返回代理
    [attrString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [attrString length]) options:0 usingBlock:^(id _value, NSRange _range, BOOL *stop)
    {
        if (_value)
        {
            if (self.attachmentDelegate && [self.attachmentDelegate respondsToSelector:@selector(textStroage:willAddAttachment:atTextRange:)])
            {
//                [self.attachmentDelegate textStroage:self willAddAttachment:_value atTextRange:_range];
                [self.attachmentDelegate textStroage:self willAddAttachment:_value atTextRange:NSMakeRange(range.location, 1)];
            }
        }
    }];
    //便利将要修改原有的string,返回代理
    NSAttributedString *string = [_imp attributedSubstringFromRange:range];
    [string enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [string length]) options:0 usingBlock:^(id value, NSRange range1, BOOL *stop) {
        if (value)
        {
            if (self.attachmentDelegate && [self.attachmentDelegate respondsToSelector:@selector(textStroage:willRemove:atTextRange:)])
            {
//                [self.attachmentDelegate textStroage:self willRemove:value atTextRange:range1];
                [self.attachmentDelegate textStroage:self willRemove:value atTextRange:NSMakeRange(range.location, 1)];
            }
        }
    }];
    
    [self beginEditing];
    [_imp replaceCharactersInRange:range withAttributedString:attrString];
    [self edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes range:range changeInLength:attrString.length - range.length];
    [self endEditing];
    
    //便利已经加入的attrString,返回代理
    [attrString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [attrString length]) options:0 usingBlock:^(id value, NSRange range1, BOOL *stop)
    {
        if (value)
        {
            if (self.attachmentDelegate && [self.attachmentDelegate respondsToSelector:@selector(textStroage:didAddAttachment:atTextRange:)])
            {
//                [self.attachmentDelegate textStroage:self didAddAttachment:value atTextRange:range1];
                [self.attachmentDelegate textStroage:self didAddAttachment:value atTextRange:NSMakeRange(range.location, 1)];
            }
        }
    }];
    
    //便利已经修改原有的string,返回代理
    [string enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, [string length]) options:0 usingBlock:^(id value, NSRange range1, BOOL *stop) {
        if (value) {
            if (self.attachmentDelegate && [self.attachmentDelegate respondsToSelector:@selector(textStroage:didRemove:atTextRange:)])
            {
//                [self.attachmentDelegate textStroage:self didRemove:value atTextRange:range1];
                [self.attachmentDelegate textStroage:self didRemove:value atTextRange:NSMakeRange(range.location, 1)];
            }
        }
    }];
}

- (void)setAttributes:(NSDictionary*)attrs range:(NSRange)range
{
    [self beginEditing];
    [_imp setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

@end
