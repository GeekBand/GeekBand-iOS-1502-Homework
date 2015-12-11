//
//  BYPopView.m
//  团购项目
//
//  Created by binglogo on 15/9/29.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYPopView.h"

@interface BYPopView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (nonatomic, assign) NSInteger selectedRow;

@end

@implementation BYPopView

+ (BYPopView *)makePopView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"BYPopView" owner:self options:nil] lastObject];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return [self.dataSource numberOfRowsInLeftTable:self];
    } else {
        return [self.dataSource popView:self subDataForRow:_selectedRow].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        static NSString *str = @"CategoryCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text = [self.dataSource popView:self titleForRow:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[self.dataSource popView:self imageForRow:indexPath.row]];
        NSArray *subDataArray = [self.dataSource popView:self subDataForRow:indexPath.row];
        if (subDataArray.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    } else {
        static NSString *str = @"CategoryCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text = [self.dataSource popView:self subDataForRow:_selectedRow][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        _selectedRow = indexPath.row;
        [_rightTableView reloadData];
        
        if ([self.delegate respondsToSelector:@selector(popView:didSelectRowAtLeftTable:)]) {
            [self.delegate popView:self didSelectRowAtLeftTable:indexPath.row];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(popView:didSelectRowAtRightTable:)]) {
            [self.delegate popView:self didSelectRowAtRightTable:indexPath.row];
        }
    }
}

@end
