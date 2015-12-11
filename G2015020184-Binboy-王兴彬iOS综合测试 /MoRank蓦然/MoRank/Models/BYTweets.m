//
//  BYTweets.m
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYTweets.h"

@implementation BYTweets

+ (BYTweets *)tweetsWithUser:(BYUser *)curUser {
    BYTweets *tweets = [[BYTweets alloc] init];
    tweets.curUser = curUser;
    return tweets;
}

- (void)configWithTweets:(NSArray *)responseArr {
    if (responseArr && responseArr.count > 0) {
//        BYTweet *lastTweet = [responseArr lastObject];
//        self.last_id = lastTweet.id;
#warning 记得判断一下是否为空
        self.list = [NSMutableArray arrayWithArray:responseArr];
    }
}

@end
