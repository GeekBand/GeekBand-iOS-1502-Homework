//
//  BYPostView.h
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYPostView;

@protocol PostViewDelegate <NSObject>

- (void)postButtonClicked:(UIButton *)button onPostView:(BYPostView *)postView;

@end

@interface BYPostView : UIView

@property (nonatomic, weak) id <PostViewDelegate> delegate;

@end
