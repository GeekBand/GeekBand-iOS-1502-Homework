//
//  BYNavigationController.m
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYNavigationController.h"
#import "BYNavItem.h"

@interface BYNavigationController ()

@end

@implementation BYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 不是根控制器时才显示navBar
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [BYNavItem navItemWithTarget:self action:@selector(back) image:@"navigationbar_back" selectedImage:@"navigationbar_back_highlighted"];
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
