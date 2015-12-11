//
//  BYHomeViewController.m
//  YeeYanHome
//
//  Created by binglogo on 15/10/9.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYHomeViewController.h"
#import "PKRevealController.h"
#import "BYRSSParser.h"
#import "BYArticleCell.h"
#import <MBProgressHUD.h>
#import "BYArticleModel.h"
#import "BYArticleViewController.h"

@interface BYHomeViewController () {
    NSString *_html;
}

@property (nonatomic, strong) NSMutableArray *articlesArr;

@end

@implementation BYHomeViewController

- (NSMutableArray *)articlesArr {
    if (!_articlesArr) {
        _articlesArr = [NSMutableArray array];
    }
    return _articlesArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_list"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_background"]];
    
    NSString *URLStr = @"http://feed.yeeyan.org/select";
    NSURL *url = [NSURL URLWithString:URLStr];
    BYRSSParser *parser = [[BYRSSParser alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [parser downloadDataFromURL:url withCompletionHandler:^(NSArray *dataArr) {
        [self.articlesArr addObjectsFromArray:dataArr];
//        NSLog(@"%ldItems%@",self.articlesArr.count,[self.articlesArr[0] content]);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

// 显示侧滑菜单
- (void)showMenu {
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articlesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BYArticleCell" forIndexPath:indexPath];
    BYArticleModel *article = self.articlesArr[indexPath.row];
    cell.titleLabel.text = article.title;
    cell.detailLabel.text = article.content;
//    cell.sourceLabel.text = article[@"link"];
//    cell.authorLabel.text = article[@"author"];
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _html = [self.articlesArr[indexPath.row] content];
//    BYArticleViewController *articleView = [[BYArticleViewController alloc] initWithHtml:html];
//    [self.navigationController pushViewController:articleView animated:YES];
    [self performSegueWithIdentifier:@"articleSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BYArticleViewController *articleView = segue.destinationViewController;
    articleView.html = _html;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
