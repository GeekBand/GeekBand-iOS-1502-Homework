//
//  ViewController.m
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYLoginViewController.h"
//#import "UMSocial.h"
#import "BYTabBarViewController.h"


@interface BYLoginViewController ()

@end

@implementation BYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)sinaLogin:(UIButton *)sender {
//    UMSocialSnsPlatform *weiboPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    weiboPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response) {
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
//            /**
//             *  微博登录获取了用户信息
//             */
//            NSLog(@"userName:%@,uid:%@,token:%@,url:%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            BYTabBarViewController *tabBarViewController = [[BYTabBarViewController alloc] init];
            [self presentViewController:tabBarViewController animated:YES completion:^{
                
            }];
//        }
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
