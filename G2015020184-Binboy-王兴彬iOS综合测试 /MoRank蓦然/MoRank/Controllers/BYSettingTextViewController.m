//
//  BYSettingTextViewController.m
//  MoRank
//
//  Created by binglogo on 15/10/16.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYSettingTextViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "BYSetTextCell.h"

@interface BYSettingTextViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSString *myTextValue;

@end

@implementation BYSettingTextViewController

- (void)settingTextVCWithTitle:(NSString *)title textValue:(NSString *)textValue doneBlock:(void (^)(NSString *))block {
    self.title = title;
    self.textValue = textValue ? textValue : @"";
    self.doneBlock = block;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTextValue = [_textValue mutableCopy];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnClicked:)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    @weakify(self);
    RAC(self.navigationItem.rightBarButtonItem, enabled) = [RACSignal combineLatest:@[RACObserve(self, myTextValue)] reduce:^id (NSString *newTextValue){
        @strongify(self);
        if ([self.textValue isEqualToString:newTextValue]) {
            return @(NO);
        } else if (newTextValue.length <= 0) {
            return @(NO);
        }
        return @(YES);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYSetTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetTextCell" forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    [cell setTextValue:_textValue andTextChangeBlock:^(NSString *textValue) {
        weakSelf.myTextValue = textValue;
    }];
    return cell;
}

#pragma mark - Custom Methods
- (void)doneBtnClicked:(id)sender {
    if (self.doneBlock) {
        self.doneBlock(_myTextValue);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
