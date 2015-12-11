//
//  BYTweets.h
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYUser.h"
#import "BYTweet.h"

@interface BYTweets : NSObject

@property (nonatomic, strong) NSString *last_id;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) BYUser *curUser;
@property (nonatomic, strong) BYTweet *nextTweet;

+ (BYTweets *)tweetsWithUser:(BYUser *)curUser;

- (void)configWithTweets:(NSArray *)responseArr;

@end
