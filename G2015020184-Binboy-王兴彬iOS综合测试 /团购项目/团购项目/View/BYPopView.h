//
//  BYPopView.h
//  团购项目
//
//  Created by binglogo on 15/9/29.
//  Copyright © 2015年 Binboy. All rights reserved.
//

// 1.声明一个协议
// 2.声明协议中的方法
// 3.声明一个遵循协议的id类型的指针
// 4.实现协议方法

#import <UIKit/UIKit.h>
@class BYPopView;

@protocol BYPopViewDataSource <NSObject>
// 制定协议方法
- (NSInteger)numberOfRowsInLeftTable:(BYPopView *)popView ;
- (NSString *)popView:(BYPopView *)popView titleForRow:(NSInteger)row;
- (NSString *)popView:(BYPopView *)popView imageForRow:(NSInteger)row;
- (NSArray *)popView:(BYPopView *)popView subDataForRow:(NSInteger)row;

@end

@protocol BYPopViewDelegate <NSObject>
// 选择左侧表时调用
- (void)popView:(BYPopView *)popView didSelectRowAtLeftTable:(NSInteger)row;
- (void)popView:(BYPopView *)popView didSelectRowAtRightTable:(NSInteger )row;


@end

@interface BYPopView : UIView

@property (nonatomic, assign) id<BYPopViewDataSource> dataSource;
@property (nonatomic, assign) id<BYPopViewDelegate> delegate;

+ (BYPopView *)makePopView;

@end
