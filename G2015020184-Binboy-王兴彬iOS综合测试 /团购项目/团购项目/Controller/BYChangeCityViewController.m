//
//  BYChangeCityViewController.m
//  团购项目
//
//  Created by binglogo on 15/9/30.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYChangeCityViewController.h"
#import "BYCityGroupsModel.h"
#import "BYSearchResultTableViewController.h"
#import "UIView+AutoLayout.h"

@interface BYChangeCityViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate> {
    NSArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) BYSearchResultTableViewController *searchResultVC;

@end

@implementation BYChangeCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"切换城市";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = item;
    
    // 获取数据源
    BYCityGroupsModel *model = [[BYCityGroupsModel alloc] init];
    _dataArray = [model getModelArray];
}

- (void)backToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] cities].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"CityCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = [_dataArray[indexPath.section] cities][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_dataArray[section] title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BYCityGroupsModel *model = _dataArray[indexPath.section];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityDidChanged" object:nil userInfo:@{@"cityName":model.cities[indexPath.row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchBar Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.coverView.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.coverView.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length) {
        self.searchResultVC.view.hidden = NO;
        self.searchResultVC.searchText = searchText;
    } else {
        self.searchResultVC.view.hidden = YES;
    }
}

#pragma mark - 创建搜索结果控制器
- (BYSearchResultTableViewController *)searchResultVC {
    // 懒加载
    if (!_searchResultVC) {
        _searchResultVC = [[BYSearchResultTableViewController alloc] init];
        // 将搜索结果VC添加到当前控制器中
        [self.view addSubview:_searchResultVC.view];
        // 添加约束，设置搜索结果控制器的尺寸位置
        [_searchResultVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [_searchResultVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar];
    }
    return _searchResultVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
