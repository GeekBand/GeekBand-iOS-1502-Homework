//
//  ViewController.m
//  MoRank
//
//  Created by binglogo on 15/10/14.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYWecomeController.h"
#import "BYTools.h"
#import "UIView+AutoLayout.h"
#import <AFNetworking.h>
#import "BYConst.h"
#import "BYHomeViewController.h"
#import "AppDelegate.h"
#import "BYUserManager.h"
#import <MBProgressHUD.h>

@interface BYWecomeController () {
    BOOL _iscontentView;
    BOOL _isLoginView;
    BOOL _isRegistView;
    UIView *contentView;
    CGFloat contentSize;
}

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UILabel *welcomLabel;
@property (weak, nonatomic) IBOutlet UILabel *sloganLabel;

@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *usernameTextField;

@end

@implementation BYWecomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _iscontentView = NO;
    _isLoginView = NO;
    _isRegistView = NO;

    [BYTools clipView:_loginButton withRadius:5];
    [BYTools clipView:_registButton withRadius:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.emailTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)loginButtonClicked:(id)sender {
    if (!_isLoginView) {
        // 显示输入框
        [self addLoginView];
    } else {
        // 真实登录
        if ([self.emailTextField.text isEqualToString:@""]||[self.passwordTextField.text isEqualToString:@""]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号或密码为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        } else {
            [self loginRequest];
        }
    }
}

- (void)addContentView {
    [self.welcomLabel removeFromSuperview];
    [self.sloganLabel removeFromSuperview];
    
    contentSize = self.view.frame.size.width - 15;
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, contentSize, contentSize)];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view addSubview:contentView];
        CGFloat centerX = self.view.center.x;
        CGFloat centerY = self.view.center.y * 1.3;
        contentView.center = CGPointMake(centerX, centerY);
    } completion:^(BOOL finished) {
        
    }];
    _iscontentView = YES;
}

- (void)addLoginView {
    // 删除两个欢迎标签
    if (!_iscontentView) {
        [self addContentView];
    }
    if (_isRegistView) {
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *subview in contentView.subviews) {
                [subview removeFromSuperview];
            }
        }];
    }
    _emailTextField = [[UITextField alloc] init];
    _emailTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kPreEmailKey];
    _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    _emailTextField.placeholder = @"请输入邮箱";
    _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    CGFloat emailW = contentSize - 20;
    CGFloat emailH = 40;
    CGFloat emailX = (contentSize - emailW) / 2;
    CGFloat emailY = 40;
    _emailTextField.frame = CGRectMake(emailX, emailY, emailW, emailH);
    [contentView addSubview:_emailTextField];

    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.placeholder = @"登录密码";
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.secureTextEntry = YES;
    CGFloat passwordW = contentSize - 20;
    CGFloat passwordH = 40;
    CGFloat passwordX = (contentSize - passwordW) / 2;
    CGFloat passwordY = CGRectGetMaxY(_emailTextField.frame) + 20;
    _passwordTextField.frame = CGRectMake(passwordX, passwordY, passwordW, passwordH);
    [contentView addSubview:_passwordTextField];
    _isLoginView = YES;
    _isRegistView = NO;
}

- (IBAction)registButtonClicked:(id)sender {
    if (!_iscontentView) {
        [self addContentView];

        _emailTextField = [[UITextField alloc] init];
        _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        _emailTextField.placeholder = @"请输入注册邮箱";
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        CGFloat emailW = contentSize - 20;
        CGFloat emailH = 40;
        CGFloat emailX = (contentSize - emailW) / 2;
        CGFloat emailY = 40;
        _emailTextField.frame = CGRectMake(emailX, emailY, emailW, emailH);
        [contentView addSubview:_emailTextField];
        
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"注册密码";
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.secureTextEntry = YES;
        CGFloat passwordW = contentSize - 20;
        CGFloat passwordH = 40;
        CGFloat passwordX = (contentSize - passwordW) / 2;
        CGFloat passwordY = CGRectGetMaxY(_emailTextField.frame) + 20;
        _passwordTextField.frame = CGRectMake(passwordX, passwordY, passwordW, passwordH);
        [contentView addSubview:_passwordTextField];
    }
    if (_isRegistView) {
        // 发送注册请求
        if ([self.usernameTextField.text isEqualToString:@""]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }else if ([self.emailTextField.text isEqualToString:@""]||[self.passwordTextField.text isEqualToString:@""]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号或密码为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        } else {
            [self registRequest];
        }
        return;
    }
    
    _usernameTextField = [[UITextField alloc] init];
    _usernameTextField.placeholder = @"用户名";
    _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    CGFloat usernameW = contentSize - 20;
    CGFloat usernameH = 40;
    CGFloat usernameX = (contentSize - usernameW) / 2;
    CGFloat usernameY = CGRectGetMaxY(_emailTextField.frame) + 20;
    _usernameTextField.frame = CGRectMake(usernameX, usernameY, usernameW, usernameH);
    [contentView addSubview:_usernameTextField];
    
    [UIView animateWithDuration:0.5 animations:^{
        _passwordTextField.placeholder = @"注册密码";
        CGFloat passwordW = contentSize - 20;
        CGFloat passwordH = 40;
        CGFloat passwordX = (contentSize - passwordW) / 2;
        CGFloat passwordY = CGRectGetMaxY(_usernameTextField.frame) + 20;
        _passwordTextField.frame = CGRectMake(passwordX, passwordY, passwordW, passwordH);
        [contentView layoutIfNeeded];
    }];
    _isRegistView = YES;
    _isLoginView = NO;
}

#pragma mark - 网络请求
// 登录
- (void)loginRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *username = @"sampleName";
//    NSString *password = @"samplePassword";
//    //        NSString *email = @"binboy886@gmail.com";
//    NSString *email = @"binboy@163.com";
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSDictionary *paras = @{@"email":email,
                            @"password":password,
                            @"gbid":kGBID};
    NSString *url = [NSString stringWithFormat:@"%@/user/login",kBaseURL];
    [manager POST:url parameters:paras success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"登录成功：%@",responseObject);
        NSDictionary *userDict = responseObject[@"data"];
        // 保存用户相关信息
        [BYUserManager saveUserWithDict:userDict];
        [BYUserManager setPreEmail:email]; //记住邮箱
        BYHomeViewController *homeContro = [self.storyboard instantiateViewControllerWithIdentifier:@"BYHomeViewController"];
        AppDelegate *appDelegate =[UIApplication sharedApplication].delegate;
        [appDelegate switchRootViewController:homeContro];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"登录返回错误：%@",operation.responseObject);
        [self solveWelcomeError:operation.responseObject];
    }];
}
// 注册
- (void)registRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *username = self.usernameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSDictionary *paras = @{@"username":username,
                            @"email":email,
                            @"password":password,
                            @"gbid":kGBID};
    NSString *url = [NSString stringWithFormat:@"%@/user/register",kBaseURL];
    [manager POST:url parameters:paras success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableDictionary *registDict = responseObject;
        NSLog(@"注册成功%@",registDict);
        // 直接登录
        [self loginRequest];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        // 注册错误
        NSLog(@"注册错误%@",operation.responseObject);
        [self solveWelcomeError:operation.responseObject];
    }];
}
// 错误处理
- (void)solveWelcomeError:(NSDictionary *)error {
    NSString *errorMessage = error[@"message"];
    NSString *messageToShow;
    //登录
    if ([errorMessage isEqualToString:@"No such user"]) {
        messageToShow = @"用户不存在";
    }
    if ([errorMessage isEqualToString:@"Wrong password"]) {
        messageToShow = @"密码错误";
    }
    //注册
    if ([errorMessage isEqualToString:@"Email exists"]) {
        messageToShow = @"邮箱已注册，请登录";
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:messageToShow delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

@end
