//
//  BYCategoryModel.m
//  团购项目
//
//  Created by binglogo on 15/9/30.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYCategoryModel.h"

@implementation BYCategoryModel

// 加载Plist文件
- (NSArray *)loadPlistData {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:file];
    NSArray *dataArray = [self getDataWithArray:plistArray];
    return dataArray;
}

// 字典转模型
- (instancetype)makeModelWithDict:(NSDictionary *)dict {
//    self.highlighted_icon = [dict objectForKey:@"highlighted_icon"];
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

// 解析Plist文件
- (NSArray *)getDataWithArray:(NSArray *)array {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        BYCategoryModel *model = [[BYCategoryModel alloc] init];
        [model makeModelWithDict:dict];
        [tempArray addObject:model];
    }
    return tempArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"BYCategoryModelUndefindedKey-%@",key);
}

@end
