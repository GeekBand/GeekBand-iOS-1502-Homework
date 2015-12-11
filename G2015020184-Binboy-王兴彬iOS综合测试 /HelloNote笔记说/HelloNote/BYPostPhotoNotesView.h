//
//  BYPostPhotosView.h
//  HelloNote
//
//  Created by binglogo on 15/9/16.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYPostPhotoNotesView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *photoNotes;

- (void)addPhotoNote:(UIImage *)image;

@end
