//
//  BYUser.h
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYUser : NSObject

@property (nonatomic, strong) NSString *avatar, *user_name, *user_id, *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSDate *created, *modified;

+ (BYUser *)userWithUserID:(NSString *)userID;

@end
