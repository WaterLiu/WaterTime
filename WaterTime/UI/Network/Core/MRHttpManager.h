//
//  MRHttpManager.h
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/1/30.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRNetworkManager.h"

typedef void (^SimpleRespond)(NSDictionary *reponseDic);

@interface MRHttpManager : MRNetworkManager

- (MRRequestHandler *)simpleRequestAsync:(NSString *)urlString completion:(void (^)(NSDictionary *reponseDic))block;

@end
