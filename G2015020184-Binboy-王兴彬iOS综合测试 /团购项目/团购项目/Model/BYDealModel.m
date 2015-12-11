//
//  BYDealModel.m
//  团购项目
//
//  Created by binglogo on 15/10/2.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYDealModel.h"

@implementation BYDealModel

- (NSArray *)assignModelWithDict:(NSDictionary *)dict {
    NSArray *dictArray = [dict objectForKey:@"deals"];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        BYDealModel *model = [[BYDealModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [arr addObject:model];
    }
    return arr;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"current_price"]) {
        self.current_price = [(NSNumber *)value stringValue];
    }
    if ([key isEqualToString:@"list_price"]) {
        self.list_price = [(NSNumber *)value stringValue];
    }
    if ([key isEqualToString:@"purchase_count"]) {
        self.purchase_count = [(NSNumber *)value stringValue];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.Description = key;
    }
}

@end
