//
//  BYPostPhotoViewController.m
//  HelloNote
//
//  Created by binglogo on 15/9/16.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYPostNoteViewController.h"
#import "BYPostToolBar.h"
#import "BYPostPhotoNotesView.h"
#import "BYTextView.h"

@interface BYPostNoteViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,BYPostToolBarDelegate,UITextViewDelegate>
// 键盘顶部工具条
@property (nonatomic, weak) BYPostToolBar *toolBar;
@property (nonatomic, weak) BYTextView *textView;
@property (nonatomic, weak) BYPostPhotoNotesView *notePhotosView;

@end

@implementation BYPostNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏左侧item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    //导航栏右侧item，默认不可用
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //设置navigationItem的titleView
    [self setupTitleView];
    
    //添加自定义的textView
    [self setupTextView];
    
    //添加键盘正上方的五合一工具条
    [self setupToolbar];
    
    //添加相册
    [self setupPhotosView];
    
}

- (void)setupPhotosView
{
    BYPostPhotoNotesView *photosView = [[BYPostPhotoNotesView alloc] init];
    
    CGFloat photosViewW = self.view.frame.size.width;
    CGFloat photosViewH = self.view.frame.size.height;
    
    photosView.frame = CGRectMake(0, 100, photosViewW, photosViewH);
    [self.textView addSubview:photosView];
    self.notePhotosView = photosView;
}

- (void)setupToolbar
{
    BYPostToolBar *toolbar = [[BYPostToolBar alloc] init];
    toolbar.delegate = self;
    
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarH = 44;
    CGFloat toolbarY = self.view.bounds.size.height - toolbarH;
    toolbar.frame = CGRectMake(0, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolBar = toolbar;
}

- (void)setupTextView
{
    BYTextView *textView = [[BYTextView alloc] init];
    textView.delegate = self;
    //垂直方向上有弹簧效果，能拖拽
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:18];
    textView.placeHolder = @"你的笔记会说话...";
    //指定占位文本的字体颜色
    textView.placeHolderColor = [UIColor grayColor];
    self.textView = textView;
    [self.view addSubview:textView];
    
    //成为第一响应者，即弹出键盘
    [self.textView becomeFirstResponder];
    
    //添加通知，监听textView输入文字状态，以便去掉占位文本
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:self.textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


//- (void)composeToolbar:(JKComposeToolbar *)toolbar didClickBtnOfType:(JKComposeToolbarButtonType)type
//{

//}

//textView开始滚动时，结束编辑状态，即关闭键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    //如果是(自定义)键盘，关闭它时，把五合一toolbar放置屏幕最底下
    CGFloat toobarY = self.view.frame.size.height - self.toolBar.frame.size.height;
    self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, toobarY, self.toolBar.frame.size.width, self.toolBar.frame.size.height);
}

- (void)textViewDidChange
{
    //textView有文字时，右侧的按钮才能点击
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupTitleView
{
    //设置navigationItem的titleView
    NSString *prefix = @"笔记说";
    self.title = prefix;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//确定发布
- (void)send
{
    if (self.notePhotosView.photoNotes.count) {
        //如果要发的微博里有图片，调用的是发照片接口
        [self sendWithImage];
        
    } else {
        //只是文字，调用的是发文字的接口
        [self sendWithText];
    }
}

- (void)sendWithText
{
    NSLog(@"发布笔记");
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"access_token"] = [JKAccountTool account].access_token;
//    params[@"status"] = self.textView.fullText;
//    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        [MBProgressHUD showSuccess:@"发布成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithImage
{
    NSLog(@"发布了图片笔记");
    //发带有图片的微博，调用的API接口不一样，afn方法也不一样
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"access_token"] = [JKAccountTool account].access_token;
//    params[@"status"] = self.textView.fullText;
//    //name:@"pic"，即要求的参数key，是pic
//    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //这个API只支持一张图片，从photos数组读取第一张，转成NSData，formData拼接之
//        UIImage *image = [self.photosView.photos firstObject];
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
//        [formData appendPartWithFileData:data name:@"pic" fileName:@"testUpload.jpg" mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"发布成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//        [MBProgressHUD showError:@"发送失败"];
//    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showCamera
{
    //弹出照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

- (void)showPicLib
{
    //弹出相册
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.notePhotosView addPhotoNote:image];
    //dissmiss相册，弹出键盘
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.textView becomeFirstResponder];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //取消选择图片时，要dismiss，并且弹出键盘
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.textView becomeFirstResponder];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGFloat toolbarW = self.view.frame.size.width;
        CGFloat toolbarH = 44;
        CGFloat toolbarY = keyboardRect.origin.y - toolbarH;
        self.toolBar.frame = CGRectMake(0, toolbarY, toolbarW, toolbarH);
    }];
}

- (void)postToolBar:(BYPostToolBar *)toolBar didClickedButtonOfType:(BYPostToolBarButtonType)buttonType {
        switch (buttonType) {
            case BYPostToolBarButtonTypeCamera:
                //打开照相机
                [self showCamera];
                break;
    
            case BYPostToolBarButtonTypePhotoLibrary:
                //打开相册
                [self showPicLib];
                break;
    
            default:
                break;
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
