//
//  BYTweet.m
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYTweet.h"

@implementation BYTweet

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化一些数据
    }
    return self;
}

+ (BYTweet *)tweetWithUserID:(NSString *)user_id andID:(NSString *)id {
    BYTweet *tweet = [[BYTweet alloc] init];
    tweet.user_id = user_id;
    tweet.id = id;
    return tweet;
}

@end
