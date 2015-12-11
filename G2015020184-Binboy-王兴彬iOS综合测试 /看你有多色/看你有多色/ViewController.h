//
//  ViewController.h
//  看你有多色
//
//  Created by brother on 15/8/14.
//  Copyright (c) 2015年 brother. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@protocol HighestRecordDelegate <NSObject>

- (NSString *)highestScore;

@end

@interface ViewController : UIViewController

@property (copy, nonatomic) NSString *highestScore;
@property (assign, nonatomic) id<HighestRecordDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *highestScroeLabel;

@end