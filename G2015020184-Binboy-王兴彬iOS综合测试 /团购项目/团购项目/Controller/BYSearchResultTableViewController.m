//
//  BYSearchResultTableViewController.m
//  团购项目
//
//  Created by binglogo on 15/9/30.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYSearchResultTableViewController.h"
#import "BYCitiesModel.h"

@interface BYSearchResultTableViewController ()

@property (nonatomic, strong) NSArray *ciciesArray;
@property (nonatomic, strong) NSMutableArray *searchResultArray;

@end

@implementation BYSearchResultTableViewController

- (NSMutableArray *)searchResultArray {
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}

- (void)setSearchText:(NSString *)searchText {
    _searchText = [searchText lowercaseString];
    // 获取城市模型数组
    if (!_ciciesArray) {
        _ciciesArray = [BYCitiesModel getCities];
    }
    [self.searchResultArray removeAllObjects];
    // 遍历判断
    for (BYCitiesModel *city in _ciciesArray) {
        if ([city.name containsString:_searchText] || [city.pinYin containsString:_searchText]||[city.pinYinHead containsString:_searchText]) {
            [self.searchResultArray addObject:city];
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"searchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.textLabel.text = [self.searchResultArray[indexPath.row] name];
    
    return cell;
}

@end

