//
//  BYSquareViewController.m
//  MoRank
//
//  Created by binglogo on 15/10/15.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYSquareViewController.h"
#import "BYTweetCell.h"
#import "BYTweets.h"
#import <AFNetworking.h>
#import "BYConst.h"

@interface BYSquareViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableDictionary *tweetsDict;
@property (nonatomic, assign) NSInteger curIndex;

@end

@implementation BYSquareViewController

- (void)awakeFromNib {
    _curIndex = 0;
    _tweetsDict = [NSMutableDictionary dictionaryWithCapacity:4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshFirst];
    // 设置myTableView
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshFirst];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tweets
- (BYTweets *)getCurTweets {
    return [_tweetsDict objectForKey:[NSNumber numberWithInteger:_curIndex]];
}
- (void)saveCurTweets:(BYTweets *)curTweets {
    [_tweetsDict setObject:curTweets forKey:[NSNumber numberWithInteger:_curIndex]];
}

#pragma mark - Request
- (void)sendRequest {
    BYTweets *curTweets = [self getCurTweets];
    if (curTweets.list.count <= 0) {
//        [self.view beginLoading];
    }
    // 请求评论列表
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/comment",kBaseURL];
    
    NSString *user_id = kUserID;
    NSString *token = kToken;
    NSDictionary *parameters = @{@"user_id":user_id,
                                 @"token":token};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"评论列表获取成功：%@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *tweetArray = dic[@"data"];
        [curTweets configWithTweets:tweetArray];
        [self refresh];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"评论列表获取失败：%@",operation.responseObject);
    }];
}

#pragma mark - Refresh Data
- (void)refreshFirst {
    [self.myTableView reloadData];
    BYTweets *curTweets = [self getCurTweets];
    if (!curTweets) {
        curTweets = [BYTweets tweetsWithUser:[BYUser userWithUserID:kUserID]];
        [self saveCurTweets:curTweets];
    }
    if (curTweets.list.count <= 0) {
        [self refresh];
    }
    [self sendRequest];
}
- (void)refresh {
    [self.myTableView reloadData];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BYTweets *curTweets = [self getCurTweets];
    if (curTweets && curTweets.list) {
        return [curTweets.list count];
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Tweet forIndexPath:indexPath];
    BYTweets *curTweets = [self getCurTweets];
    NSDictionary *tweet = curTweets.list[indexPath.row];
    cell.textLabel.text = tweet[@"comment"];
    return cell;
}

@end
