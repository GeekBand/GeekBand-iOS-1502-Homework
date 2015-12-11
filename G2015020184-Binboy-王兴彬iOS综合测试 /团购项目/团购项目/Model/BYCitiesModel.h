//
//  BYCitiesModel.h
//  团购项目
//
//  Created by binglogo on 15/10/1.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYCitiesModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pinYin;
@property (nonatomic, copy) NSString *pinYinHead;
@property (nonatomic, strong) NSArray *regions;

+ (NSArray *)getCities;

@end
