//
//  MRJSONModel.m
//  MRNetworkDemo
//
//  Created by gaoyuan on 16/1/13.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRJSONModel.h"
#import <objc/runtime.h>

@implementation MRJSONModel

#pragma mark - 生命周期
/**
 *  通过Dictionary方式初始化Model
 *
 *  @param dic 要创建的Dictionary
 *
 */
-(instancetype)initWithDictionary:(NSDictionary *)dic error:(NSError **)error{
    self = [super init];
    if (self) {
        [self parseModel:dic error:error];
    }
    return self;
}
/**
 *  通过JSON字符串的方式创建Model
 *
 *  @param jsonString 要创建的字符串
 *
 */
-(instancetype)initWithJSONString:(NSString *)jsonString error:(NSError **)error{
    self = [super init];
    if (self) {
        
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:error];
        [self parseModel:dic error:error];
    }
    return self;
}
#pragma mark - 内部方法
/**
 *  解析方法
 */
-(void)parseModel:(NSDictionary *)dic error:(NSError **)error{
    unsigned int propertyCount;
    NSArray *dicKeys = [dic allKeys];//得到所有的Key
    
    
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        
        //取属性名称
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        //属性类型
        NSString *propertyAttribute = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSArray* attributeItems = [propertyAttribute componentsSeparatedByString:@","];
        if ([attributeItems containsObject:@"R"]) {//如果属性是只读的，就不要进行解析了
            continue;
        }
        if ([dicKeys containsObject:propertyName]) {//如果属性存在在key中
            if ([dic[propertyName] isKindOfClass:[NSDictionary class]]) {//如果key对应的value是一个Dictionary
                NSString *className = [self getAttributeString:propertyAttribute];
                MRJSONModel *model = [[NSClassFromString(className) alloc] initWithDictionary:dic[propertyName]];
                [self setValue:model forKey:propertyName];
            }else if ([dic[propertyName] isKindOfClass:[NSArray class]]){//如果key对应的value是一个Array
                NSMutableArray *array = [NSMutableArray new];
                NSString *classArrayName = [self getAttributeString:propertyAttribute];
                
                //得到Array中具体的类
                NSScanner* scanner = [NSScanner scannerWithString:classArrayName];
                NSString* protocolName = nil;
                while ([scanner scanString:@"NSArray<" intoString:NULL]) {
                    [scanner scanUpToString:@">" intoString: &protocolName];
                    [scanner scanString:@">" intoString:NULL];
                }
                if (protocolName) {
                    for (NSDictionary *value_dic in dic[propertyName]) {
                        MRJSONModel *model = [[NSClassFromString(protocolName) alloc] initWithDictionary:value_dic];
                        [array addObject:model];
                    }
                    [self setValue:array forKey:propertyName];
                }
            }else{
                
                if (dic[propertyName]==nil) {//如果为空
                    [self setValue:nil forKey:propertyName];
                }else{
                    [self setValue:dic[propertyName] forKey:propertyName];
                }
            }
            
        }
    }
}

/**
 *  将属性字符串进行精简，得到需要的类名或者变量类型
 *
 *  @param attribute 要精简的属性字符串
 *
 *  @return 精简的字符串
 */
-(NSString *)getAttributeString:(NSString *)attribute{
    NSUInteger loc = 1;
    NSUInteger len = [attribute rangeOfString:@","].location - loc;
    NSString *type = [attribute substringWithRange:NSMakeRange(loc, len)];
    if ([type hasPrefix:@"@"]) {//如果是以@开头，表明是个类，再进行截取得到具体的类名
        type = [[type substringToIndex:[type length]-1] substringFromIndex:2];
    }
    return type;
}

@end
