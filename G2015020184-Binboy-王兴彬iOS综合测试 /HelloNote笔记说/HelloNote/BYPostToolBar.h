//
//  BYPostToolBar.h
//  HelloNote
//
//  Created by binglogo on 15/9/16.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BYPostToolBarButtonTypeCamera,
    BYPostToolBarButtonTypePhotoLibrary,
} BYPostToolBarButtonType;

@class BYPostToolBar;

@protocol BYPostToolBarDelegate <NSObject>

@optional

- (void)postToolBar:(BYPostToolBar *)toolBar didClickedButtonOfType:(BYPostToolBarButtonType) buttonType;

@end

@interface BYPostToolBar : UIView

@property (nonatomic, assign) BYPostToolBarButtonType buttonType;
@property (nonatomic, weak) id <BYPostToolBarDelegate> delegate;

@end
