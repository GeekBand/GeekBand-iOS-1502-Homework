//
//  BYArticleViewController.h
//  YeeYanHome
//
//  Created by binglogo on 15/10/12.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYArticleViewController : UIViewController

@property (nonatomic, strong) NSString *html;

- (instancetype)initWithHtml:(NSString *)html;

@end
