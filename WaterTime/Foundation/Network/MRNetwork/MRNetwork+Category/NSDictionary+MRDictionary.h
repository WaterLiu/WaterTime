//
//  NSDictionary+MRDictionary.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/11.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MRDictionary)

-(NSString*) mr_urlEncodedKeyValueString;
-(NSString*) mr_jsonEncodedKeyValueString;
-(NSString*) mr_plistEncodedKeyValueString;

- (id)parseToClass:(NSString *)className keyMapDic:(NSDictionary *)keyMapDic;

@end
