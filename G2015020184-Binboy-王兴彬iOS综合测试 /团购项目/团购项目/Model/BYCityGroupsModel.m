//
//  BYCityGroupsModel.m
//  团购项目
//
//  Created by binglogo on 15/9/30.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYCityGroupsModel.h"

@implementation BYCityGroupsModel{
    NSArray *_plistArray;
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadPlist];
    }
    return self;
}

- (void)loadPlist {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityGroups" ofType:@"plist"];
    _plistArray = [NSArray arrayWithContentsOfFile:path];
}

- (NSArray *)getModelArray {
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in _plistArray) {
        BYCityGroupsModel *model = [[BYCityGroupsModel alloc] init];
        model.cities = [dict objectForKey:@"cities"];
        model.title = [dict objectForKey:@"title"];
        [dataArray addObject:model];
    }
    return dataArray;
}

@end
