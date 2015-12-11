//
//  BYArticleCell.m
//  YeeYanHome
//
//  Created by binglogo on 15/10/10.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYArticleCell.h"

@implementation BYArticleCell

- (void)awakeFromNib {
    self.backView.layer.cornerRadius = 8;
    self.backView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
