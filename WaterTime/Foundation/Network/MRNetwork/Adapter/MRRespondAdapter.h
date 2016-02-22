//
//  MRRespondAdapter.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRRequest.h"

@class MRRespond;

//负责 Respond 转 MRRespondModel
@interface MRRespondAdapter : NSObject

+ (MRRespond *)parseRespond:(NSURLResponse *)response responseObject:(id)responseObject request:(MRRequest *)request error:(NSError *)error;
@end

