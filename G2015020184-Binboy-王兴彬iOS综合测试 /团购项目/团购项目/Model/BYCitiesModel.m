//
//  BYCitiesModel.m
//  团购项目
//
//  Created by binglogo on 15/10/1.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYCitiesModel.h"

@implementation BYCitiesModel

+ (NSArray *)getCities {
    // 1. 加载plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dict in plistArray) {
        BYCitiesModel *cityModel = [[BYCitiesModel alloc] init];
        [cityModel setValuesForKeysWithDictionary:dict];
        [modelArray addObject:cityModel];
    }
    return modelArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"CitiesModelUndefinedKey--%@",key);
}

@end
