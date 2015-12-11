//
//  BYCutLabel.m
//  团购项目
//
//  Created by binglogo on 15/10/2.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYCutLabel.h"

@implementation BYCutLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    /*
     1.获取上下文
     2.设置画线起点位置
     3.画线至终点
     4.渲染
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, rect.size.height * 0.5);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height * 0.5);
    CGContextStrokePath(context);
}

@end
