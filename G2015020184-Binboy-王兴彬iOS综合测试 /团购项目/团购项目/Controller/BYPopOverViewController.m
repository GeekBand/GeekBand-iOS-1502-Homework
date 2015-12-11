//
//  BYPopViewController.m
//  团购项目
//
//  Created by binglogo on 15/9/29.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYPopOverViewController.h"
#import "BYPopView.h"
#import "BYCategoryModel.h"

@interface BYPopOverViewController ()<BYPopViewDataSource, BYPopViewDelegate>{
    NSArray *_categoryArray;
    BYCategoryModel *_selectedModel;
}

@end

@implementation BYPopOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _categoryArray = [self getData];
    
    BYPopView *pop = [BYPopView makePopView];
    [self.view addSubview:pop];
    pop.dataSource = self;
    pop.delegate = self;
    pop.autoresizingMask = UIViewAutoresizingNone;
    self.preferredContentSize = CGSizeMake(pop.frame.size.width, pop.frame.size.height);
}

- (NSArray *)getData {
    BYCategoryModel *model = [[BYCategoryModel alloc] init];
    NSArray *categoryArray = [model loadPlistData];
    return categoryArray;
}

#pragma mark - BYPopViewDataSource 
- (NSInteger)numberOfRowsInLeftTable:(BYPopView *)popView {
    return _categoryArray.count;
}

- (NSString *)popView:(BYPopView *)popView titleForRow:(NSInteger)row {
    return [_categoryArray[row] name];
}

- (NSString *)popView:(BYPopView *)popView imageForRow:(NSInteger)row {
    return [_categoryArray[row] small_icon];
}

- (NSArray *)popView:(BYPopView *)popView subDataForRow:(NSInteger)row {
    return [_categoryArray[row] subcategories];
}

#pragma mark - BYPopView Delegate
- (void)popView:(BYPopView *)popView didSelectRowAtLeftTable:(NSInteger)row {
    _selectedModel = _categoryArray[row];
    if (!_selectedModel.subcategories.count) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"categoryDidChange" object:nil userInfo:@{@"categoryModel":_selectedModel}];
    }
}

- (void)popView:(BYPopView *)popView didSelectRowAtRightTable:(NSInteger)row {
    NSArray *subArray = _selectedModel.subcategories;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"subCategoryDidChange" object:nil userInfo:@{@"subCategoryName":subArray[row],@"categoryModel":_selectedModel}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
