//
//  BYCityGroupsModel.h
//  团购项目
//
//  Created by binglogo on 15/9/30.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYCityGroupsModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *cities;

- (NSArray *)getModelArray;

@end
