//
//  BYSetHeadImgController.m
//  MoRank
//
//  Created by binglogo on 15/10/19.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYSetHeadImgController.h"
#import "BYAPIManager.h"

@interface BYSetHeadImgController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *choseImgBtn;

@end

@implementation BYSetHeadImgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)headImgBtn:(id)sender {
    [self setAvatar];
}
- (IBAction)completeSet:(id)sender {
    //提交修改头像请求
    NSData *imageData = UIImageJPEGRepresentation(self.headImage.image, 0.8);
    [[BYAPIManager sharedManager] uploadUserImage:imageData withUserID:@"326" completion:^(NSError *error, NSDictionary *responseDict) {
        if (error) {
            // 提示失败
            return;
        }
        // 成功
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

// 设置头像
- (void)setAvatar {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}
- (void)chooseImageWithType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        picker.sourceType = type;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self chooseImageWithType:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            [self chooseImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        default:
            break;
    }
}

#pragma mark - ImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.headImage.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.choseImgBtn setTitle:@"重新选择" forState:UIControlStateNormal];
    }];
    
}

@end
