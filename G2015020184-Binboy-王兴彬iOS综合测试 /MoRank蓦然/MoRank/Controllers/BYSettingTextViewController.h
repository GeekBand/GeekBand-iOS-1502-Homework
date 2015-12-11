//
//  BYSettingTextViewController.h
//  MoRank
//
//  Created by binglogo on 15/10/16.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYBaseViewController.h"

@interface BYSettingTextViewController : BYBaseViewController

@property (nonatomic, strong) NSString *textValue;
@property (nonatomic, copy) void (^doneBlock)(NSString *textValue);

- (void)settingTextVCWithTitle:(NSString *)title textValue:(NSString *)textValue doneBlock:(void (^)(NSString *textValue)) block;

@end
