//
//  MRRespond.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRParse.h"
#import "MREntityParse.h"
#import "MRArrayParse.h"
#import "MRDicParse.h"

@class MRRequest;

@protocol MRRespondProtocol <MREntityParseProtocol>

@property (nonatomic,strong)        MRRequest               *request;

- (NSString *)description;

@end

@interface MRRespond : NSObject<MRRespondProtocol>



@end



@interface MRUploadRespond : MRRespond



@end


@interface MRDownloadRespond : MRRespond



@end

