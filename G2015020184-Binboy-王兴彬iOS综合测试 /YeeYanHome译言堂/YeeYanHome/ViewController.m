//
//  ViewController.m
//  YeeYanHome
//
//  Created by binglogo on 15/10/9.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BYMenuViewController"];
    self.frontViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BYHomeViewControllerNav"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
