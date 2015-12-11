//
//  BYPostPhotosView.m
//  HelloNote
//
//  Created by binglogo on 15/9/16.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYPostPhotoNotesView.h"

#define kNotePhotoMaxCols(count) ((count == 4) ? 2 : 3)

@implementation BYPostPhotoNotesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _photoNotes = [NSMutableArray array];
    }
    return self;
}

- (void)addPhotoNote:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    [self.photoNotes addObject:image];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int maxCols = 3;
    CGFloat imageViewWH = 70;
    CGFloat margin = 10;
    int imageViewIndex = 0;
    for (UIImageView *imageView in self.subviews) {
        int col = imageViewIndex % maxCols;
        int row = imageViewIndex / maxCols;
        CGFloat imageViewX = col * (imageViewWH + margin);
        CGFloat imageViewY = row * (imageViewWH + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWH, imageViewWH);
        imageViewIndex++;
    }
}

@end
