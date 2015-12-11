//
//  AppDelegate.m
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "AppDelegate.h"
#import "BYLoginViewController.h"
#import "BYGuideViewController.h"
//#import "UMSocial.h"
//#import "UMSocialSinaHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isFristUse"] isEqualToString:@"YES"] ) {
        BYLoginViewController *loginVC = [mainStory instantiateViewControllerWithIdentifier:@"login"];
        self.window.rootViewController = loginVC ;
        
        
    }else{
        BYGuideViewController *guideCV = [mainStory instantiateViewControllerWithIdentifier:@"guide"];
        self.window.rootViewController = guideCV ;
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"isFristUse"];
        
    }
    [self.window makeKeyAndVisible];
    
    /**
     *  设置友盟AppKey: 55f78ee5e0f55a50bb002b0f
     */
//    [UMSocialData setAppKey:@"55f78ee5e0f55a50bb002b0f"];
//    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
