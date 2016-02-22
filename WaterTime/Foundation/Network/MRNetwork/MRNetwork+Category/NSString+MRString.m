//
//  NSString+MRString.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/11.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "NSString+MRString.h"

@implementation NSString (MRString)

- (NSString*) mr_urlEncodedString
{
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    if(!encodedString)
    {
        encodedString = @"";
    }
    return encodedString;
}

- (NSString*) mr_urlDecodedString
{
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(__bridge CFStringRef) self,CFSTR(""),kCFStringEncodingUTF8);
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}


@end
