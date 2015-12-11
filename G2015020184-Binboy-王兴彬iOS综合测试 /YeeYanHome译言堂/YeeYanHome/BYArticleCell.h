//
//  BYArticleCell.h
//  YeeYanHome
//
//  Created by binglogo on 15/10/10.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYArticleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;

@end
