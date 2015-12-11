//
//  ViewController.m
//  看你有多色
//
//  Created by brother on 15/8/14.
//  Copyright (c) 2015年 brother. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.delegate = segue.destinationViewController;
}

- (void)viewWillAppear:(BOOL)animated {
    if ([self.highestScroeLabel.text intValue] < [[self.delegate highestScore] intValue]) {
        self.highestScroeLabel.text = [self.delegate highestScore];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    self.highestScore = self.highestScroeLabel.text;
}

@end
