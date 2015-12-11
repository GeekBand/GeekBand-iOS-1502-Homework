//
//  BYBaseNavController.m
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYBaseNavController.h"

@interface BYBaseNavController ()

@end

@implementation BYBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationBar.backgroundColor = [UIColor clearColor];
//    self.navigationBar.translucent = YES;
    self.navigationBar.barTintColor = [UIColor colorWithRed:237/255.f green:127/255.f blue:74/255.f alpha:1.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
