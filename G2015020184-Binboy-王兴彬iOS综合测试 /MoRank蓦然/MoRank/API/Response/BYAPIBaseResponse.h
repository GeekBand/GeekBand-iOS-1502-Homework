//
//  BYAPIBaseResponse.h
//  MoRank
//
//  Created by FellowPlus-Binboy on 15/12/11.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYAPIBaseResponse : NSObject

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSDictionary *data;

+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject;

@end
