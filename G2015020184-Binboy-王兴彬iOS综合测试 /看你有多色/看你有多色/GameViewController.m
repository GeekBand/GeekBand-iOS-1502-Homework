//
//  GameViewController.m
//  看你有多色
//
//  Created by brother on 15/8/14.
//  Copyright (c) 2015年 brother. All rights reserved.
//

#import "GameViewController.h"

#define kGameTime 10 //游戏时长
#define kBlockMargin 5 //游戏块间隙
#define kDiffrentLevel 0.7 //游戏难度，即颜色差值

@interface GameViewController () {
    int gameLevel; //游戏级别
    int gameScore; //游戏分数
    NSUInteger correctBlockIndex; //正确游戏块索引
}

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *gameContentView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation GameViewController {
    double boardW;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self gameStart];
}

//开始游戏
- (void)gameStart {
    [self gameTimer]; //触发计时器
    [self loadGame];  //初始化加载
}
//初始化加载
- (void)loadGame {
    gameLevel = 1;
    gameScore = 0;
    [self updateGameLevel];
}
//更新游戏视图界面
- (void)updateGameLevel {
//    [UIView beginAnimations:@"ShowHideView" context:nil];
//    [UIView setAnimationDuration:0.5];
    /*删除已有游戏块*/
//    NSArray *allGameBlocks = [self.gameContentView subviews];
//    for (UIButton *block in allGameBlocks) {
//        [block removeFromSuperview];
//    }
    [self.gameContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    /*根据游戏级别更新游戏块*/
    //随机产生颜色
    CGFloat red = 1.0 / arc4random_uniform(15);
    CGFloat green = 1.0 / arc4random_uniform(15);
    CGFloat blue = 1.0 / arc4random_uniform(15);
//    NSLog(@"r:%fg:%fb:%f",red,green,blue);
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.9];
    //统一添加游戏块
    for (int i = 0; i < gameLevel + 1; i++) {
        for (int j = 0; j < gameLevel + 1; j++) {
            UIButton *gameBlock = [UIButton buttonWithType:UIButtonTypeCustom];
            gameBlock.backgroundColor = randomColor; //设置统一随机颜色
//            boardW = self.gameContentView.frame.size.width;
            boardW = [UIScreen mainScreen].bounds.size.width;
            double blockW = (boardW - kBlockMargin * (gameLevel + 2)) / (gameLevel + 1);
            double blockX = kBlockMargin + (kBlockMargin + blockW) * j;
            double blockY = kBlockMargin + (kBlockMargin + blockW) * i;
            gameBlock.frame = CGRectMake(blockX,blockY, blockW, blockW);
            gameBlock.layer.cornerRadius = 6;
            gameBlock.layer.masksToBounds = YES;
            [self.gameContentView addSubview:gameBlock];
            [gameBlock addTarget:self action:@selector(gameBlockClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //随机取出正确块，并个性化设置近似颜色
    int numberOfAllBlocks = (gameLevel + 1) * (gameLevel + 1);
    int randomIndex = arc4random_uniform(numberOfAllBlocks);
    correctBlockIndex =  (NSUInteger) randomIndex;
    NSArray *allGameBlocks = [self.gameContentView subviews];
    UIColor *yesColor = [UIColor colorWithRed:red green:green blue:blue alpha:kDiffrentLevel];
    [allGameBlocks[correctBlockIndex] setBackgroundColor:yesColor];
    [allGameBlocks[correctBlockIndex] setTag:5];
//    for (UIButton *block in allGameBlocks) {
//        if ([allGameBlocks indexOfObject:block] == randomIndex) {
//            block.backgroundColor = yesColor;
//            block.tag = 5;
//        }
//    }
    //更新得分
    self.scoreLabel.text = [NSString stringWithFormat:@"%02d",gameScore];
//    [UIView commitAnimations];
}
//计时器方法
- (void)gameTimer {
    self.timeLabel.text = [NSString stringWithFormat:@"%d",kGameTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimeLabel) userInfo:nil repeats:YES];
}
//计时更新
- (void)changeTimeLabel {
    int timeCount = [self.timeLabel.text intValue];
    if (timeCount > 0) {
        timeCount--;
        self.timeLabel.text = [NSString stringWithFormat:@"%d",timeCount];
    } else {
        self.scoreLabel.text = [NSString stringWithFormat:@"%02d",gameScore];
        NSString *message = [NSString stringWithFormat:@"得分：%d",gameScore];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"时间到，游戏结束"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"嗯"
                                              otherButtonTitles:nil];
        [alert show];
        [self.timer invalidate];
    }
}
//暂停游戏
- (IBAction)pauseButtonClicked:(UIButton *)sender {
    if (sender.selected == NO) {
        sender.selected = YES;
        self.timer.fireDate = [NSDate distantFuture];
//        UIAlertView *pauseAlert = [[UIAlertView alloc] initWithTitle:@"暂停"
//                                                             message:@"稍事休息"
//                                                            delegate:nil
//                                                   cancelButtonTitle:@"揉揉眼睛再战！"
//                                                   otherButtonTitles:nil];
        [self.gameContentView setUserInteractionEnabled:NO];
        UILabel *pauseMask = [[UILabel alloc] init];
        pauseMask.frame = self.gameContentView.frame;
        pauseMask.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
        pauseMask.text = @"稍事休息，揉揉眼睛再战";
        pauseMask.textColor = [UIColor whiteColor];
        pauseMask.textAlignment = NSTextAlignmentCenter;
        pauseMask.tag = 25;
        [self.gameContentView.superview addSubview:pauseMask];
    } else {
        sender.selected = NO;
        self.timer.fireDate = [NSDate date];
        [self.gameContentView setUserInteractionEnabled:YES];
        [[self.gameContentView.superview viewWithTag:25] removeFromSuperview];
    }
}
//游戏块点击
- (void)gameBlockClicked:(UIButton *)sender {
    if (sender.tag == 5) {
        ++gameLevel;
        [self updateGameLevel];
        gameScore += (gameLevel + 1) * 3;
    }else {
        self.scoreLabel.text = [NSString stringWithFormat:@"%02d",gameScore];
        NSString *message = [NSString stringWithFormat:@"得分：%d",gameScore];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"色色哒你"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"嗯" otherButtonTitles:nil];
        [alert show];
        //更新得分
    }
    
}
//UIAlert代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:^{
        //游戏完成
    }];
}

- (NSString *)highestScore {
    return self.scoreLabel.text;
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
