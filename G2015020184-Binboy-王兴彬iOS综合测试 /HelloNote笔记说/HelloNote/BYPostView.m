//
//  BYPostView.m
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYPostView.h"

@interface BYPostView ()

@property (nonatomic, strong) UIButton *textPostBtn;

@end

@implementation BYPostView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addPostOptionButtons];
    }
    return self;
}

- (void)addPostOptionButtons {
    
    UIButton *textPostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [textPostBtn setImage:[UIImage imageNamed:@"texttool-on"] forState:UIControlStateNormal];
    [textPostBtn setBackgroundImage:[UIImage imageNamed:@"bg_joblist_search"] forState:UIControlStateNormal];
    [textPostBtn setImage:[UIImage imageNamed:@"texttool-down"] forState:UIControlStateHighlighted];
    [textPostBtn addTarget:self action:@selector(postNote:) forControlEvents:UIControlEventTouchUpInside];
    textPostBtn.tag = kPostTextButtonTag;
    [self addSubview:textPostBtn];

    UIButton *photoPostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoPostBtn setImage:[UIImage imageNamed:@"inktool-on"] forState:UIControlStateNormal];
    [photoPostBtn setBackgroundImage:[UIImage imageNamed:@"bg_joblist_search"] forState:UIControlStateNormal];
    [photoPostBtn setImage:[UIImage imageNamed:@"inktool-down"] forState:UIControlStateHighlighted];
    [photoPostBtn addTarget:self action:@selector(postNote:) forControlEvents:UIControlEventTouchUpInside];
    photoPostBtn.tag = kPostPhotoButtonTag;
    [self addSubview:photoPostBtn];
    
    UIButton *cameraPostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraPostBtn setImage:[UIImage imageNamed:@"cameratool-on"] forState:UIControlStateNormal];
    [cameraPostBtn setBackgroundImage:[UIImage imageNamed:@"bg_joblist_search"] forState:UIControlStateNormal];
    [cameraPostBtn setImage:[UIImage imageNamed:@"cameratool-down"] forState:UIControlStateHighlighted];
    [cameraPostBtn addTarget:self action:@selector(postNote:) forControlEvents:UIControlEventTouchUpInside];
    cameraPostBtn.tag = kPostCameraButtonTag;
    [self addSubview:cameraPostBtn];
    
}

- (void)postNote:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(postButtonClicked:onPostView:)]) {
        [self.delegate postButtonClicked:sender onPostView:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 15;
    [self clipsToBounds];
    [UIView animateWithDuration:0.2f animations:^{
        CGFloat frameW = [UIScreen mainScreen].bounds.size.width * 0.6;
        CGFloat frameH = [UIScreen mainScreen].bounds.size.height * 0.15;
        self.frame = CGRectMake(0, 0, frameW, frameH);
        CGFloat centerX = [UIScreen mainScreen].bounds.size.width * 0.5;
        CGFloat centerY = [UIScreen mainScreen].bounds.size.height - 115;
        self.center = CGPointMake(centerX, centerY);
        self.backgroundColor = [UIColor darkGrayColor];
    } completion:^(BOOL finished) {
        int btnIndex = 0;
        for (UIButton *optionsBtn in self.subviews) {
            CGFloat margin = (self.frame.size.width - self.subviews.count * 60) / self.subviews.count;
            CGFloat btnW = 60;
            CGFloat btnH = 60;
            CGFloat btnX = btnIndex * (btnW + margin)+ margin * 0.5 ;
            CGFloat btnY = (self.frame.size.height - btnH) * 0.5;
            optionsBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btnIndex++;
        }
    }];
}

@end
