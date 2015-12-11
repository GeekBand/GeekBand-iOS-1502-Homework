//
//  BYArticleViewController.m
//  YeeYanHome
//
//  Created by binglogo on 15/10/12.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYArticleViewController.h"

@interface BYArticleViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;

@property (nonatomic, assign) BOOL isFinishedLoading;

@end

@implementation BYArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_background"]];
    
    [self initSubviews];
//    [self setAutoLayout];
    _isFinishedLoading = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    //    self.revealController.frontViewController.revealController.recognizesPanningOnFrontView = NO;
    
    if (_isFinishedLoading) {return;}
    NSLog(@"%@",_html);
    [_articleWebView loadHTMLString:_html baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithHtml:(NSString *)html
{
    self = [super init];
    if (self) {
        _html = html;
    }
    return self;
}

- (void)initSubviews
{
    UIWebView *webView = [[UIWebView alloc] init];
    //_readme = [[UIWebView alloc] initWithFrame:self.view.bounds];   //不用autolayout，这样设置的话，如果内容很长，底部会有些内容显示不全，原因未知
    _articleWebView.delegate = self;
    _articleWebView.scrollView.bounces = NO;
    _articleWebView.opaque = NO;
    _articleWebView.backgroundColor = [UIColor redColor];
    _articleWebView.scalesPageToFit = NO;
    _articleWebView.hidden = YES;
    _articleWebView = webView;
    [self.view addSubview:_articleWebView];
}

- (void)setAutoLayout
{
    [_articleWebView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_articleWebView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_articleWebView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_articleWebView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_articleWebView)]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (_isFinishedLoading) {
        webView.hidden = NO;
        //        [self.view hideToastActivity];
        webView.scalesPageToFit = YES;
        return;
    }
    
    NSString *bodyWidth= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth "];
    int widthOfBody = [bodyWidth intValue];
    
    //获取实际要显示的html
    NSString *adjustedHTML = [self htmlAdjustWithPageWidth:widthOfBody
                                                      html:_html
                                                   webView:webView];
    
    //加载实际要现实的html
    [_articleWebView loadHTMLString:adjustedHTML baseURL:nil];
    
    //设置为已经加载完成
    _isFinishedLoading = YES;
}

//获取宽度已经适配于webView的html。这里的原始html也可以通过js从webView里获取
- (NSString *)htmlAdjustWithPageWidth:(CGFloat)pageWidth
                                 html:(NSString *)html
                              webView:(UIWebView *)webView
{
    //计算要缩放的比例
    CGFloat initialScale = webView.frame.size.width/pageWidth;
    
    NSString *header = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\" initial-scale=%f, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\">", initialScale];
    
    NSString *newHTML = [NSString stringWithFormat:@"<html><head>%@</head><body>%@</body></html>", header, html];
    
    return newHTML;
}



@end
