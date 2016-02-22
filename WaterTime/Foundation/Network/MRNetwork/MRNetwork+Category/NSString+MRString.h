//
//  NSString+MRString.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/11.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MRString)

- (NSString*) mr_urlEncodedString;
- (NSString*) mr_urlDecodedString;

@end
