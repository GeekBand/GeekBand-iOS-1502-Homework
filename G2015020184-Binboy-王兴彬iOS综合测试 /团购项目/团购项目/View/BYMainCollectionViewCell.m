//
//  BYMainCollectionViewCell.m
//  团购项目
//
//  Created by binglogo on 15/10/2.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYMainCollectionViewCell.h"
#import "BYDealModel.h"
#import "UIImageView+WebCache.h"

@interface BYMainCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;

@end

@implementation BYMainCollectionViewCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
    self.backgroundView = bgView;
}

- (void)showUIWithModel:(BYDealModel *)model {
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.Description;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@", model.current_price];
    self.oldPriceLabel.text = model.list_price;
    self.saleNumLabel.text = model.purchase_count;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
}

@end
