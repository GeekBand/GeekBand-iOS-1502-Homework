//
//  BYAPIManager.m
//  MoRank
//
//  Created by FellowPlus-Binboy on 15/12/11.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYAPIManager.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "AFHTTPRequestOperationManager.h"
#import "BYConst.h"
#import "BYAPIBaseResponse.h"

static NSString * const kBYBaseURLString = @"http://moran.chinacloudapp.cn/moran/web/";

@interface BYAPIManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BYAPIManager

+ (instancetype)sharedManager
{
    static BYAPIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BYAPIManager alloc] init];
    });
    
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        NSURL *baseURL = [NSURL URLWithString:kBYBaseURLString];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *finalParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//    DDLogVerbose(@"%@", finalParameter);
    
    NSDictionary *baseParameters = @{
                                     //        @"code": @"code",
                                     @"version": [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"],
                                     @"os": @"iOS",
                                     @"osVersion": [[UIDevice currentDevice] systemVersion]
                                     };
    
    [finalParameter addEntriesFromDictionary:baseParameters];
    
    if (self.token) {
        [finalParameter addEntriesFromDictionary:@{ @"token": self.token }];
    }
    
    [self.manager POST:URLString parameters:finalParameter constructingBodyWithBlock:block success:success failure:false];
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *finalParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//    DDLogVerbose(@"%@", finalParameter);
    
    NSDictionary *baseParameters = @{
                                     //        @"code": @"code",
                                     @"version": [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"],
                                     @"os": @"iOS",
                                     @"osVersion": [[UIDevice currentDevice] systemVersion]
                                     };
    
    [finalParameter addEntriesFromDictionary:baseParameters];
    
    if (self.token) {
        [finalParameter addEntriesFromDictionary:@{ @"token": self.token }];
    }
    
    [self.manager POST:URLString parameters:finalParameter success:success failure:failure];
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *finalParameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSDictionary *baseParameters = @{
                                     //        @"code": @"code",
                                     @"version": [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"],
                                     @"os": @"iOS",
                                     @"osVersion": [[UIDevice currentDevice] systemVersion]
                                     };
    
    if (self.token) {
        [finalParameter addEntriesFromDictionary:@{ @"token": self.token }];
    }
    
    [finalParameter addEntriesFromDictionary:baseParameters];
    [self.manager GET:URLString parameters:finalParameter success:success failure:failure];
}

- (void)signUpWithEmail:(NSString *)email userName:(NSString *)username password:(NSString *)password completion:(void (^)(NSError *error))completion
{
    NSDictionary *params = @{@"username":username,
                             @"email":email,
                             @"password":password,
                             @"gbid":kGBID};
    [self POST:@"user/register" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        BYAPIBaseResponse *response = [BYAPIBaseResponse responseWithResponseObject:responseObject];
        if (response.error) {
            if (completion) {
                completion(response.error);
            }
        } else {
            if (completion) {
                completion(nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(error);
        }
    }];
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSError *, BYUserAPIModel *, NSString *))completion
{
    NSDictionary *params = @{@"email":email,
                            @"password":password,
                            @"gbid":kGBID};
    [self POST:@"user/login" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        BYAPIBaseResponse *response = [BYAPIBaseResponse responseWithResponseObject:responseObject];
        if (response.error) {
            if (completion) {
                completion(response.error, nil, nil);
            }
        } else {
            BYUserAPIModel *user = [BYUserAPIModel initWithDict:response.data];
            NSString *token = response.data[@"token"];
            self.token = token;
            if (completion) {
                completion(nil, user, token);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(error, nil, nil);
        }
    }];
}

- (void)uploadUserImage:(NSData *)imageData withUserID:(NSString *)userID completion:(void (^)(NSError *, NSDictionary *))completion
{
    NSDictionary *params = @{@"user_id":userID};
    [self POST:@"user/avatar" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        BYAPIBaseResponse *response = [BYAPIBaseResponse responseWithResponseObject:responseObject];
        if (completion) {
            completion(nil, response.data);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(error, nil);
        }
    }];
}

@end
