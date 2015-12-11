//
//  BYArticleModel.h
//  YeeYanHome
//
//  Created by binglogo on 15/10/10.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYArticleModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * link;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * author;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
