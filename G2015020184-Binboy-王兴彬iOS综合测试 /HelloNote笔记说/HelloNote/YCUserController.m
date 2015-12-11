//
//  YCUserController.m
//  笔记说个人中心
//
//  Created by brother on 15/9/16.
//  Copyright (c) 2015年 brother. All rights reserved.
//

#import "YCUserController.h"
#import "YCHeadCell.h"
#import "YCSettingCell.h"
#import "YCExitCell.h"
#import "YCUserAnswerController.h"
#import "YCGuideController.h"
#import "YCCollectController.h"
#import "YCPersonNoteController.h"

@interface YCUserController ()

@property (nonatomic, strong)NSArray *settingImages;

@property (nonatomic, strong)NSArray *settingTexts;

@end

@implementation YCUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingImages = [NSArray arrayWithObjects:@"笔记",@"收藏",@"指南",@"反馈", nil];
    
    self.settingTexts = [NSArray arrayWithObjects:@"个人笔记",@"个人收藏",@"使用指南",@"意见反馈", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YCHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadCell" forIndexPath:indexPath];
        cell.headImageView.layer.cornerRadius = 10;
        cell.headImageView.layer.masksToBounds = YES;
        return cell;
    }else {
        if (indexPath.section == 1) {
            YCSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
            cell.settingImage.image = [UIImage imageNamed:self.settingImages[indexPath.row]];
            cell.settingText.text = self.settingTexts[indexPath.row];
            return cell;
        }else if (indexPath.section == 2) {
            YCExitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExitCell"];
            return cell;
        }else {
            return nil;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            YCPersonNoteController *noteContro = [[YCPersonNoteController alloc] init];
            
            [self presentViewController:noteContro animated:YES completion:nil];
            
        } else if (indexPath.row == 1) {
            YCCollectController *collectContro = [[YCCollectController alloc] init];
            
            [self presentViewController:collectContro animated:YES completion:nil];
         
        } else if (indexPath.row == 2) {
            YCGuideController *guideContro = [[YCGuideController alloc] init];
            
            [self presentViewController:guideContro animated:YES completion:nil];
            
        } else {
            YCUserAnswerController *answerContro = [[YCUserAnswerController alloc] init];
            
            [self presentViewController:answerContro animated:YES completion:nil];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 22;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else {
        return 50;
    }
}

@end
