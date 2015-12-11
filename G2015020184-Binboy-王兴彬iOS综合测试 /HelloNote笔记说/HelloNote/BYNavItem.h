//
//  BYNavItem.h
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYNavItem : NSObject

+ (UIBarButtonItem *)navItemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage;

@end
