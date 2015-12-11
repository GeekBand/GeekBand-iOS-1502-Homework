//
//  BYMyProfileController.m
//  MoRank
//
//  Created by binglogo on 15/10/16.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYMyProfileController.h"
#import "BYConst.h"
#import "BYUserManager.h"
#import "AppDelegate.h"
#import "BYSettingTextViewController.h"
#import <AFNetworking.h>
#import "BYSetHeadImgController.h"

@interface BYMyProfileController () <UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) NSArray *profileArr;

@end

@implementation BYMyProfileController

- (NSArray *)profileArr {
    if (!_profileArr) {
        _profileArr = @[@{@"img":@"nickname",@"title":@"更改昵称"},
                        @{@"img":@"headimage",@"title":@"设置头像"},
                        @{@"img":@"signout",@"title":@"注销登录"},
                        @{@"img":@"rate",@"title":@"评价我们"},
                        @{@"img":@"follow",@"title":@"关注我们"},
                        @{@"img":@"homepage",@"title":@"官方网站"},];
    }
    return _profileArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:kUserDict][@"user_name"];
    self.nameLabel.text = userName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
    NSDictionary *item = [NSDictionary dictionary];
    if (indexPath.section == 0) {
        item = self.profileArr[indexPath.row];
    } else if(indexPath.section == 1) {
        item = self.profileArr[indexPath.row + 3];
    }
    NSString *img = item[@"img"];
    cell.imageView.image = [UIImage imageNamed:img];
    cell.textLabel.text = item[@"title"];
    
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self changeNickname];
                break;
            case 1:{
                // 设置头像
                BYSetHeadImgController *headContro = [self.storyboard instantiateViewControllerWithIdentifier:@"BYSetHeadImgController"];
                [self presentViewController:headContro animated:YES completion:^{
                    
                }];
            }
                break;
            case 2:
                [self signOut];
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                NSLog(@"评价我们");
                break;
            case 1:
                
                break;
            case 2:
                
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - Selection Method
// 退出登录
- (void)signOut {
    [BYUserManager deleteCurUser];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UIViewController *welcomeContro = [self.storyboard instantiateViewControllerWithIdentifier:@"BYWecomeController"];

    [UIView animateWithDuration:0.8 animations:^{
        for (UIView *subview in self.view.subviews) {
            [subview removeFromSuperview];
        }
        CGFloat centerX = self.view.frame.size.width * 0.5;
        CGFloat centerY = self.view.frame.size.height * 0.5;
        self.navigationController.tabBarController.view.frame = CGRectMake(centerX - 50, centerY - 50, 100, 100);
    } completion:^(BOOL finished) {
        [appDelegate switchRootViewController:welcomeContro];
    }];
}
// 更改昵称
- (void)changeNickname {
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] valueForKey:kUserDict];
    NSString *curName = userDict[@"user_name"];
    __weak BYMyProfileController *weakSelf = self;
    BYSettingTextViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BYSettingTextViewController"];
    [vc settingTextVCWithTitle:@"修改昵称" textValue:curName doneBlock:^(NSString *textValue) {
        weakSelf.nameLabel.text = textValue;
        AFHTTPRequestOperationManager *mannager = [AFHTTPRequestOperationManager manager];
        NSString *url = [NSString stringWithFormat:@"%@/user/rename",kBaseURL];
        NSDictionary *parameters = @{@"user_id":kUserID,
                                     @"token":kToken,
                                     @"new_name":textValue};
        [mannager POST:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"更改用户名成功：%@",responseObject);
            NSDictionary *dataDict = responseObject[@"data"];
            [BYUserManager saveUserWithDict:dataDict];
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"更改用户名失败：%@",operation.responseObject);
        }];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
