//
//  BYFirstViewController.m
//  团购项目
//
//  Created by binglogo on 15/9/29.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYFirstViewController.h"
#import "BYNavItem.h"
#import "BYPopOverViewController.h"
#import "BYSecondPopOverController.h"
#import "BYCityGroupsModel.h"
#import "BYCategoryModel.h"
#import "DPAPI.h"
#import "BYDealModel.h"
#import "BYMainCollectionViewCell.h"
#import "MJRefresh.h"

@interface BYFirstViewController ()<DPRequestDelegate>{
    UIBarButtonItem *firstItem;
    UIBarButtonItem *secondItem;
    UIBarButtonItem *thirdItem;
    
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    
    NSMutableArray *_dataSource;
}

@property (nonatomic, assign) int page;

@end

@implementation BYFirstViewController

static NSString  * const reuseIdentifier = @"MainCell";

- (instancetype)init {
    if (self = [super init]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(300, 300);
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        self = [self initWithCollectionViewLayout:layout];
    }
    return self;
}

#pragma mark - 屏幕旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    int col = 2;
    if (size.width == 1024) {
        col = 3;
    }
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = (size.width - col * layout.itemSize.width) / (col + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    // 上下间距
    layout.minimumLineSpacing = inset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BYMainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self createNavBar];
    _dataSource = [NSMutableArray array];
    self.navigationController.navigationBar.autoresizingMask = NO;
    // 始终可上下滑动
    self.collectionView.alwaysBounceVertical = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryChange:) name:@"categoryDidChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subCategoryChange:) name:@"subCategoryDidChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange:) name:@"cityDidChanged" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityDidChanged" object:nil userInfo:@{@"cityName":@"北京"}];
    // 下拉刷新
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self createRequest];
        [self.collectionView.header endRefreshing];
    }];
    // 上拉加载
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        [self.collectionView.footer endRefreshing];
    }];
}

#pragma mark - 创建导航栏
- (void)createNavBar {
    //1. logo
    UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];

    //2. 3个UIBarButtonItem
    BYNavItem *first = [BYNavItem makeNavItem];
    [first addTarget:self action:@selector(firstClicked)];
    BYNavItem *second = [BYNavItem makeNavItem];
    [second addTarget:self action:@selector(secondClicked)];
    BYNavItem *third = [BYNavItem makeNavItem];
    
    firstItem = [[UIBarButtonItem alloc] initWithCustomView:first];
    secondItem = [[UIBarButtonItem alloc] initWithCustomView:second];
    thirdItem = [[UIBarButtonItem alloc] initWithCustomView:third];
    
    self.navigationItem.leftBarButtonItems = @[logo, firstItem, secondItem, thirdItem];
}
- (void)categoryChange:(NSNotification *)notification {
    [_dataSource removeAllObjects];
    BYCategoryModel *category = notification.userInfo[@"categoryModel"];
    if (!category.subcategories.count) {
        _selectedCategory = category.name;
    }
    // 发送网络请求
    [self createRequest];
}

- (void)subCategoryChange:(NSNotification *)notification {
    [_dataSource removeAllObjects];
    BYCategoryModel *category = notification.userInfo[@"categoryModel"];
    NSString *subCategoryName = notification.userInfo[@"subCategoryName"];
    if (!category.subcategories.count) {
        _selectedCategory = category.name;
    } else {
        if ([subCategoryName isEqualToString:@"全部"]) {
            _selectedCategory = category.name;
        } else {
            _selectedCategory = subCategoryName;
        }
    }
    [self createRequest];
    
}

- (void)cityChange:(NSNotification *)notification {
    [_dataSource removeAllObjects];
    _selectedCityName = notification.userInfo[@"cityName"];
    [self createRequest];
}
#pragma mark - 网络请求
- (void)loadMoreData {
    _page++;
    [self request];
}

- (void)createRequest {
    self.page = 1;
    [self request];
}

- (void)request {
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_selectedCityName forKey:@"city"];
    [params setValue:_selectedCategory forKey:@"category"];
    [params setValue:@(_page) forKey:@"page"];
    params[@"limit"] = @6;
    [api requestWithURL:@"v1/deal/find_deals" params:params  delegate:self];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    NSDictionary *dict = result;
    BYDealModel *model = [[BYDealModel alloc] init];
    NSArray *array = [model assignModelWithDict:dict];
    [_dataSource addObjectsFromArray:array];
    [self.collectionView reloadData];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"fail%@",[error localizedDescription]);
}

#pragma mark - 点击事件
- (void)firstClicked {
    [self createPopover];
}

- (void)secondClicked {
    [self creatSecondPopView];
}

#pragma mark - 第一个下拉菜单
- (void)createPopover {
    UIViewController *pvc = [[BYPopOverViewController alloc] init];
    UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:pvc];
    [pop presentPopoverFromBarButtonItem:firstItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - 第二个下拉菜单
- (void)creatSecondPopView {
    BYSecondPopOverController *svc = [[BYSecondPopOverController alloc] initWithNibName:@"BYSecondPopOverController" bundle:nil];
    UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:svc];
    [pop presentPopoverFromBarButtonItem:secondItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    [self viewWillTransitionToSize:collectionView.frame.size withTransitionCoordinator:nil];
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BYMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell showUIWithModel:_dataSource[indexPath.item]];
    return cell;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
