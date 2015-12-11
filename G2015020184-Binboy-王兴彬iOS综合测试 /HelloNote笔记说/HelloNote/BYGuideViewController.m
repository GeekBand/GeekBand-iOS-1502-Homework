//
//  BYGuideViewController.m
//  HelloNote
//
//  Created by brother on 15/9/16.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYGuideViewController.h"
#import "BYLoginViewController.h"

@interface BYGuideViewController ()

@end

@implementation BYGuideViewController

-(void)viewDidAppear:(BOOL)animated{




}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self showIntroWithCrossDissolve];
    
   
}
- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"欢迎来到我们世界";
    page1.desc = @"我们来自何方，我们的心在何方";
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"你的笔记和我分享";
    page2.desc = @"Clear Your Mental Space";
    page2.bgImage = [UIImage imageNamed:@"2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"新的旅程已经开启";
    page3.desc = @"Relish the Moment ";
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}
- (void)introDidFinish {
    
    BYLoginViewController *byLogionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentViewController:byLogionViewController animated:YES completion:^{
        
    }];
    
    NSLog(@"Intro callback");
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
