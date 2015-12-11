//
//  BYGuideViewController.h
//  HelloNote
//
//  Created by brother on 15/9/16.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"

@interface BYGuideViewController : UIViewController<EAIntroDelegate>
- (void)showIntroWithCrossDissolve ;
- (void)introDidFinish ;
@end
