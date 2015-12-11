//
//  YCUserInfoController.m
//  笔记说个人中心
//
//  Created by brother on 15/9/16.
//  Copyright (c) 2015年 brother. All rights reserved.
//

#import "YCUserInfoController.h"
#import "YCHeadInforCell.h"
#import "YCUserInfoCell.h"



@interface YCUserInfoController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSArray *titleArray;   //用来存左边的标题

@property (nonatomic, strong) NSArray *inforArray;   //用来存右边的数据

@property (nonatomic, strong) UIImage *headImage;

@end

@implementation YCUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = [NSArray arrayWithObjects:@[@"名字",@"账号",@"电话",@"我的地址",@"性别",@"个性签名"], nil];
    
    self.inforArray = [NSArray arrayWithObjects:@[@"浪客剑心",@"744018973@qq.com",@"13681824914",@"江苏扬州",@"男",@"6666"],nil];
    
    self.headImage = [UIImage imageNamed:@"msg5"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 6;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 22;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0;
//}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else {
        return 50;
    }
}

// tableView的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YCHeadInforCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadInforCell"];
        cell.headImage.image = self.headImage;
        return cell;
    }else {
        YCUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.lefiTitle.text = self.titleArray[0][indexPath.row];
        
        cell.infoText.text = self.inforArray[0][indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self startChoosePhoto];
    } else {
       
    }
}

//开始创建actionSheet
- (void)startChoosePhoto {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

// actionSheet的代理方法，用来设置每个按钮点击的触发事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //构建图像选择器
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    [pickerController setDelegate:(id)self];
    
    if (buttonIndex == 0) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [pickerController.view setTag:actionSheet.tag];
        [self.view.window.rootViewController presentViewController:pickerController animated:YES completion:nil];
    } else if(buttonIndex == 1){
        pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [self.view.window.rootViewController presentViewController:pickerController animated:YES completion:nil];
    }
    else{
        [actionSheet setHidden:YES];
    }
}

// 图像选择器选取好后，将图片数据拿过来
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
    self.headImage = [UIImage imageWithData:imgData];
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
