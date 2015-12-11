//
//  BYNavItem.h
//  团购项目
//
//  Created by binglogo on 15/9/29.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYNavItem : UIView

+ (nonnull instancetype)makeNavItem;

- (void)addTarget:(nonnull id)target action:(nonnull SEL)action;

@end
