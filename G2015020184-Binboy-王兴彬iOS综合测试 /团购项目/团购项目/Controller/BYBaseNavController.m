//
//  BYBaseNavController.m
//  团购项目
//
//  Created by binglogo on 15/9/29.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYBaseNavController.h"

@implementation BYBaseNavController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
