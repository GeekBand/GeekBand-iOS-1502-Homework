//
//  BYTweet.h
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYUser.h"

@interface BYTweet : NSObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSDate *created, *modified;
@property (nonatomic, strong) NSString *pic_id, *shop_id, *user_id, *id;

@property (nonatomic, strong) BYUser *owner;

+ (BYTweet *)tweetWithUserID:(NSString *)user_id andID:(NSString *)id;

@end
