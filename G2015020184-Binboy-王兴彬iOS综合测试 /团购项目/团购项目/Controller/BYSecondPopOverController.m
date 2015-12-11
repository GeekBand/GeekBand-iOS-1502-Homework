//
//  BYSecondPopOverController.m
//  团购项目
//
//  Created by binglogo on 15/9/30.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYSecondPopOverController.h"
#import "BYChangeCityViewController.h"
#import "BYBaseNavController.h"

@interface BYSecondPopOverController ()

@end

@implementation BYSecondPopOverController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)changeCityClicked:(id)sender {
    BYChangeCityViewController *cvc = [[BYChangeCityViewController alloc] initWithNibName:@"BYChangeCityViewController" bundle:nil];
    BYBaseNavController *nav = [[BYBaseNavController alloc] initWithRootViewController:cvc];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
    
    
}


@end
