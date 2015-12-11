//
//  BYUserAPIModel.m
//  MoRank
//
//  Created by FellowPlus-Binboy on 15/12/11.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYUserAPIModel.h"

@implementation BYUserAPIModel

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    BYUserAPIModel *user = [[BYUserAPIModel alloc] init];
    user.userID = dict[@"user_id"];
    user.userName = dict[@"user_name"];
    user.avatar = dict[@"avatar"];
    
    return user;
}

- (NSDictionary *)dict
{
    NSDictionary *dict = [NSDictionary dictionary];
    
    return dict;
}

@end
