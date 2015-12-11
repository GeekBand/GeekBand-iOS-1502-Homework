//
//  BYConst.h
//  MoRank
//
//  Created by binglogo on 15/10/14.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYConst : NSObject

#ifndef BYConst

#define kBaseURL          @"http://moran.chinacloudapp.cn/moran/web"
#define kGBID             @"G2015020184"

#define kPreEmailKey      @"PreEmailKey"
#define kUserDict         @"UserDict"
#define kToken           [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]
#define kUserID      [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"]

#define kBYErrorDomain    @"com.binboy.morank"

#endif

@end
