//
//  BYUserAPIModel.h
//  MoRank
//
//  Created by FellowPlus-Binboy on 15/12/11.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYUserAPIModel : NSObject

@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *avatar;

+ (instancetype)initWithDict:(NSDictionary *)dict;
- (NSDictionary *)dict;

@end
