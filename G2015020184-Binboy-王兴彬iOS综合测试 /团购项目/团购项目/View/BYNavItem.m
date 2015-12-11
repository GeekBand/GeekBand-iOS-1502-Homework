//
//  BYNavItem.m
//  团购项目
//
//  Created by binglogo on 15/9/29.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYNavItem.h"

@interface BYNavItem ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation BYNavItem

+ (instancetype)makeNavItem {
    return [[[NSBundle mainBundle] loadNibNamed:@"BYNavItem" owner:self options:nil] firstObject];
}

- (void)addTarget:(id)target action:(SEL)action {
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
