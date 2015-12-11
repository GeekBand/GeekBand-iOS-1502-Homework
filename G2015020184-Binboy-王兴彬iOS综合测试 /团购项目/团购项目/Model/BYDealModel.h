//
//  BYDealModel.h
//  团购项目
//
//  Created by binglogo on 15/10/2.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYDealModel : NSObject

@property (nonatomic, copy) NSString *categories;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *current_price;
@property (nonatomic, copy) NSString *deal_h5_url;
@property (nonatomic, copy) NSString *deal_url;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *s_image_url;
@property (nonatomic, copy) NSString *list_price;
@property (nonatomic, copy) NSString *purchase_deadline;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *purchase_count;

- (NSArray *)assignModelWithDict:(NSDictionary *)dict;

@end
