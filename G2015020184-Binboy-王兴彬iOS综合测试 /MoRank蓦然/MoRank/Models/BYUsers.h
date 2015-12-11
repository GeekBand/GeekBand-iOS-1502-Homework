//
//  BYUsers.h
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYUser.h"

@interface BYUsers : NSObject

@property (nonatomic, strong) NSNumber *currentPage, *pageCount, *totalCount, *perPage;
@property (nonatomic, strong) NSDictionary *propertyArrayMap;
@property (nonatomic, strong) NSMutableArray *list;
//@property (nonatomic, strong) BYUser *owner;???

@end
