//
//  BYUserManager.h
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYUserManager : NSObject
/**
 *  记住用户邮箱
 *
 *  @param emailStr 登录成功的邮箱
 */
+ (void)setPreEmail:(NSString *)emailStr;
/**
 *  保存当前用户信息
 */
+ (void)saveUserWithDict:(NSDictionary *)dict;
/**
 *  删除当前用户信息
 */
+ (void)deleteCurUser;
@end
