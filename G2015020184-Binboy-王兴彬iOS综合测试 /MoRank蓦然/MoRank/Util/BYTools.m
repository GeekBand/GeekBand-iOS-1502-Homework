//
//  BYTools.m
//  MoRank
//
//  Created by binglogo on 15/10/14.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYTools.h"

@implementation BYTools
/**
 *  切圆角
 */
+ (void)clipView:(UIView *)view withRadius:(CGFloat)radius {
    view.layer.cornerRadius = radius;
    view.clipsToBounds = YES;
}
@end
