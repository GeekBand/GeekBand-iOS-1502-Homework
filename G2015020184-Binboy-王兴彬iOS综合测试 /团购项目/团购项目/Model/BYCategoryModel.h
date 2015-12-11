//
//  BYCategoryModel.h
//  团购项目
//
//  Created by binglogo on 15/9/30.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYCategoryModel : NSObject

// 图标
@property (copy, nonatomic) NSString *highlighted_icon;
@property (copy, nonatomic) NSString *small_highlighted_icon;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *small_icon;
// 名称
@property (copy, nonatomic) NSString *name;
// 子数据数据
@property (strong, nonatomic) NSArray *subcategories;

- (NSArray *)loadPlistData;

@end
