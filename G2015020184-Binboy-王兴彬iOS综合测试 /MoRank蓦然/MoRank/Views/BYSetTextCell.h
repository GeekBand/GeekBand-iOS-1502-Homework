//
//  BYSetTextCell.h
//  MoRank
//
//  Created by binglogo on 15/10/16.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYSetTextCell : UITableViewCell

- (void)setTextValue:(NSString *)textValue andTextChangeBlock:(void(^)(NSString *textValue))block;

@end
