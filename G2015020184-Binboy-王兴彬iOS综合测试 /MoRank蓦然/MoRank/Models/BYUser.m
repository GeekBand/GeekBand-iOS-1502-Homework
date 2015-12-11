//
//  BYUser.m
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYUser.h"

@implementation BYUser

+ (BYUser *)userWithUserID:(NSString *)userID {
    BYUser *curUser = [[BYUser alloc] init];
    curUser.user_id = userID;
    return curUser;
}

@end
