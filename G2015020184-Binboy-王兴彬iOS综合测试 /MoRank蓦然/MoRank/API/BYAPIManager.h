//
//  BYAPIManager.h
//  MoRank
//
//  Created by FellowPlus-Binboy on 15/12/11.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYUserAPIModel.h"

@interface BYAPIManager : NSObject

@property (nonatomic, strong) NSString *token;

+ (instancetype)sharedManager;

- (void)signUpWithEmail:(NSString *)email userName:(NSString *)username password:(NSString *)password completion:(void (^)(NSError *error))completion;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSError *error, BYUserAPIModel *user, NSString *token))completion;

- (void)uploadUserImage:(NSData *)imageData withUserID:(NSString *)userID
             completion:(void (^)(NSError *error, NSDictionary *responseDict))completion;

@end
