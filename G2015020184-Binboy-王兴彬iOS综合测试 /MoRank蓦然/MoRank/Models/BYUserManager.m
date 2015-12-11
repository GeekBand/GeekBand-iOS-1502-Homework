//
//  BYUserManager.m
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYUserManager.h"
#import "BYConst.h"

@interface BYUserManager ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation BYUserManager

- (NSUserDefaults *)userDefaults {
    if (!_userDefaults) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }

    return _userDefaults;
}

+ (void)setPreEmail:(NSString *)emailStr {
    if (emailStr.length <= 0) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:emailStr forKey:kPreEmailKey];
    [defaults synchronize];
}

+ (void)saveUserWithDict:(NSDictionary *)dict {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (dict) {
        [defaults setObject:dict forKey:kUserDict];
    }
    
    NSString *user_id = dict[@"user_id"];
    NSString *token = dict[@"token"];
    if (user_id) {
        [defaults setObject:user_id forKey:@"user_id"];
    }
    if (token) {
        [defaults setObject:token forKey:@"token"];
    }
    
    [defaults synchronize];
}

+ (void)deleteCurUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kUserDict];
    [defaults removeObjectForKey:@"user_id"];
    [defaults removeObjectForKey:@"token"];
    [defaults synchronize];
}

@end
