//
//  BYBaseNavController.m
//  YeeYanHome
//
//  Created by binglogo on 15/10/9.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYBaseNavController.h"

@interface BYBaseNavController ()

@end

@implementation BYBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background"] forBarMetrics:UIBarMetricsDefault];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topIcon"]];
    iconView.center = self.navigationBar.center;
    [self.navigationBar addSubview:iconView];
//    self.navigationItem.titleView = iconView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
