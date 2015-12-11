//
//  BYMainCollectionViewCell.h
//  团购项目
//
//  Created by binglogo on 15/10/2.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BYDealModel;

@interface BYMainCollectionViewCell : UICollectionViewCell

- (void)showUIWithModel:(BYDealModel *)model;

@end
