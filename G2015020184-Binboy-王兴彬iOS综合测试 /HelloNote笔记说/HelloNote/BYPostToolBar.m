//
//  BYPostToolBar.m
//  HelloNote
//
//  Created by binglogo on 15/9/16.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYPostToolBar.h"

@implementation BYPostToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        //依次添加按钮到toolbar
        [self setupBtnWithImageName:@"compose_camerabutton_background" highlightImageName:@"compose_camerabutton_background_highlighted" type:BYPostToolBarButtonTypeCamera];
        
        [self setupBtnWithImageName:@"compose_toolbar_picture" highlightImageName:@"compose_toolbar_picture_highlighted" type:BYPostToolBarButtonTypePhotoLibrary];
        
    }
    return self;
}

- (UIButton *)setupBtnWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName type:(BYPostToolBarButtonType)type
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    //把ToolbarButtonType以tag的形式存起来
    btn.tag = type;
    //按钮被点击时，通知代理
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(postToolBar:didClickedButtonOfType:)]) {
        [self.delegate postToolBar:self didClickedButtonOfType:btn.tag];
    }
}

- (void)layoutSubviews
{
    //布局五个按钮
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.frame.size.width / (count + 3);
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnH = self.frame.size.height;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}


@end
