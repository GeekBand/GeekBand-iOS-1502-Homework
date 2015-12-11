//
//  BYArticleModel.m
//  YeeYanHome
//
//  Created by binglogo on 15/10/10.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYArticleModel.h"

@implementation BYArticleModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.content = value;
    }
}

@end
