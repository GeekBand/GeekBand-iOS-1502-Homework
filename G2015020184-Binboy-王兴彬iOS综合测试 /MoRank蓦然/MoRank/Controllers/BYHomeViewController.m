//
//  BYThreeViewController.m
//  经典UI框架
//
//  Created by binglogo on 15/9/10.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYHomeViewController.h"
#import "BYNavItem.h"

@interface BYHomeViewController ()


@end

@implementation BYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupNavigationBar];
    [self setupPhotoButton];
    [self.tabBar setBackgroundColor:[UIColor redColor]];
    [self.tabBar setTintColor:[UIColor darkGrayColor]];
}

- (void)setupPhotoButton {
    
    CGFloat btnW = self.view.frame.size.width/2-60;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnW, -25, 120, 50)];
    [button setImage:[UIImage imageNamed:@"pubilsh"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"pubilsh_hover"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(publishTweet) forControlEvents:UIControlEventTouchUpInside];

    [self.tabBar addSubview:button];
}

- (void)publishTweet {
    NSLog(@"发布蓦然");
}

@end
