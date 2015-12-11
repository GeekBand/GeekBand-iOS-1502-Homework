//
//  BYTabBar.m
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYTabBar.h"

@interface BYTabBar ()

@property (nonatomic, weak) UIView *placeHolderView;

@end

@implementation BYTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // TabBar中间按钮占位
        UIView *placeHolderView = [[UIView alloc] init];
        
        [self addSubview:placeHolderView];
        self.placeHolderView = placeHolderView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = self.frame.size.width / 3.f;
    CGFloat btnH = self.frame.size.height;
    
    self.placeHolderView.frame = CGRectMake(0, 0, btnW, btnH);
    
    CGFloat btnCenterX = self.frame.size.width * 0.5;
    CGFloat btnCenterY = self.frame.size.height * 0.5;
    self.placeHolderView.center = CGPointMake(btnCenterX, btnCenterY);
    
    int tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        
        if (tabBarButtonIndex == 1) {
            tabBarButtonIndex++;
        }

        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGFloat childW = self.frame.size.width / (self.subviews.count - 2);
            CGFloat childH = child.frame.size.height;
            CGFloat childX = tabBarButtonIndex * childW;
            CGFloat childY = child.frame.origin.y;
            child.frame = CGRectMake(childX, childY, childW, childH);
            tabBarButtonIndex++;
        }
    }
}

@end
