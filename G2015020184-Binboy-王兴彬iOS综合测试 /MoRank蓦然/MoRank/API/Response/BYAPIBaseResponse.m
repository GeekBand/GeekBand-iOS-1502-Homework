//
//  BYAPIBaseResponse.m
//  MoRank
//
//  Created by FellowPlus-Binboy on 15/12/11.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYAPIBaseResponse.h"
#import "BYConst.h"

@implementation BYAPIBaseResponse

+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject
{
    BYAPIBaseResponse *response = [[BYAPIBaseResponse alloc] init];
    
    NSNumber *code = [responseObject valueForKey:@"status"];
    NSDictionary *data = [responseObject valueForKey:@"data"];
    NSString *message = [responseObject valueForKey:@"message"];
    response.data = data;
    
    if (code.integerValue != 1) {
        NSError *error = [NSError errorWithDomain:kBYErrorDomain code:code.integerValue userInfo:@{@"message": message}];
        response.error = error;
        
//        DDLogError(@"Error:%@", error);
    }
    
    return response;
}

@end
