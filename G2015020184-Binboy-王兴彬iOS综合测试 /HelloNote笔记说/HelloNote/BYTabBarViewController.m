//
//  BYTabBarViewController.m
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYTabBarViewController.h"
#import "BYHomeViewController.h"
#import "BYPopularViewController.h"
#import "BYNavigationController.h"
#import "BYTabBar.h"
#import "BYPostView.h"
#import "TWPhotoPickerController.h"
#import "BYPostNoteViewController.h"
#import "HACollectionViewLargeLayout.h"
#import "HACollectionViewSmallLayout.h"
#import "HATransitionController.h"
#import "BYSmallCollectionViewController.h"

@interface BYTabBarViewController () <PostViewDelegate,UINavigationControllerDelegate, HATransitionControllerDelegate>

@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) HATransitionController *transitionController;

@end

@implementation BYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainFrame];
}

#pragma mark - Custom Methods

- (void)loadMainFrame {
    
    // 定制TabBar
    BYTabBar *tabBar = [[BYTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    // 创建TabBar模块的控制器，并设置TabBarItem状态图片和title
    
        HACollectionViewSmallLayout *smallLayout = [[HACollectionViewSmallLayout alloc] init];
    
    BYHomeViewController *homeViewController = [[BYHomeViewController alloc] initWithCollectionViewLayout:smallLayout];
    homeViewController.title = @"主页";
//    [self addChildVCWithChildVC:homeViewController image:@"icon_home_nor" selectedImage:@"icon_home_pre"];
    
    

//    BYSmallCollectionViewController *collectionViewController = [[BYSmallCollectionViewController alloc] initWithCollectionViewLayout:smallLayout];

    self.navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    self.navigationController.delegate = self;
//    self.navigationController.navigationBarHidden = YES;
    
    self.transitionController = [[HATransitionController alloc] initWithCollectionView:homeViewController.collectionView];
    self.transitionController.delegate = self;
    
    self.navigationController.tabBarItem.image = [UIImage imageNamed:@"icon_home_nor"];
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_home_pre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:self.navigationController];
    
    BYPopularViewController *popularViewController = [[BYPopularViewController alloc] init];
    popularViewController.title = @"人气榜";
    [self addChildVCWithChildVC:popularViewController image:@"icon_find_nor" selectedImage:@"icon_find_pre"];
    
    [self addPlusButton];
}

#pragma mark - Custom Methods

- (void)addChildVCWithChildVC:(UIViewController *)childVC image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置两种状态下的图片，特别是选中时图片不能被系统渲染成蓝色，要保持原来的橙色
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置两种状态下的文字样式
    NSMutableDictionary *normalTextAttrs = [[NSMutableDictionary alloc] init];
    normalTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVC.tabBarItem setTitleTextAttributes:normalTextAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttrs = [[NSMutableDictionary alloc] init];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:64/255.0 green:148/255.0 blue:113/255.0 alpha:1.0];
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    //每个模块都是各自导航控制器的根控制器
    BYNavigationController *nav = [[BYNavigationController alloc] initWithRootViewController:childVC];
    //添加每个nav控制器至tabBarVC
    [self addChildViewController:nav];
}

- (void)addPlusButton {
    
    UIButton *plusView = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusView setImage:[UIImage imageNamed:@"home-view-new-space-up"] forState:UIControlStateNormal];
    [plusView setImage:[UIImage imageNamed:@"home-view-new-space-down"] forState:UIControlStateHighlighted];
    
    CGFloat plusW = 60 ;
    CGFloat plusH = plusW ;
    plusView.frame = CGRectMake((self.view.frame.size.width - plusW) / 2.f, self.view.frame.size.height - plusH, plusW, plusH);
    
    [plusView addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:plusView];
    self.plusButton = plusView;
}

- (void)postTextNote {
    NSLog(@"发文字笔记");
    BYPostNoteViewController *postNoteViewController = [[BYPostNoteViewController alloc] init];
    BYNavigationController *postNav = [[BYNavigationController alloc] init];
    [postNav addChildViewController:postNoteViewController];
    [self presentViewController:postNav animated:YES completion:nil];
}

- (void)postPhotoNote {
    NSLog(@"发图片笔记");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        BYPostNoteViewController *photoPostViewController = [[BYPostNoteViewController alloc] init];
        [self presentViewController:photoPostViewController animated:YES completion:nil];
    }
}

- (void)postCameraNote {
    NSLog(@"拍照发笔记");
}

- (void)plusButtonClicked:(UIButton *)sender {
    
    self.plusButton.selected = !self.plusButton.selected;
    if (self.plusButton.selected) {
        UIButton *fullView = [[UIButton alloc] initWithFrame:self.view.frame];
        fullView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
        fullView.tag = 333;
        fullView.userInteractionEnabled = YES;
        [fullView addTarget:self action:@selector(fullMaskViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.plusButton.backgroundColor = [UIColor whiteColor];
        self.plusButton.layer.cornerRadius = 30;
        [self.plusButton clipsToBounds];
        [UIView animateWithDuration:0.2f animations:^{
            [sender setTransform:CGAffineTransformMakeRotation(M_PI_4 * 3)];
        }];
        BYPostView *postView = [[BYPostView alloc] initWithFrame:CGRectMake(self.plusButton.center.x, self.plusButton.center.y, 0, 0)];
        postView.tag = 200;
        postView.delegate = self;
        [self.view addSubview:fullView];
        [fullView addSubview:postView];
        [self.view bringSubviewToFront:self.plusButton];
    } else {
        UIView *fullView = [self.view viewWithTag:333];
        [fullView removeFromSuperview];
        [UIView animateWithDuration:0.2f animations:^{
        [sender setTransform:CGAffineTransformMakeRotation(0.f)];
        sender.backgroundColor = [UIColor clearColor];
        }];
        [[self.view viewWithTag:200] removeFromSuperview];
    }

}

- (void) fullMaskViewClicked:(UIButton *)sender {
    [self plusButtonClicked:self.plusButton];
}

#pragma mark - PostViewDelegate Methods

- (void)postButtonClicked:(UIButton *)button onPostView:(BYPostView *)postView {
    
    if (button.tag == kPostTextButtonTag /*文字*/) {
        [self postTextNote];
    } else if (button.tag == kPostPhotoButtonTag /*照片*/) {
        [self postPhotoNote];
    } else if (button.tag == kPostCameraButtonTag /*拍照*/) {
        [self postCameraNote];
    }
    
    [self plusButtonClicked:self.plusButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)interactionBeganAtPoint:(CGPoint)point
{
    // Very basic communication between the transition controller and the top view controller
    // It would be easy to add more control, support pop, push or no-op
    BYSmallCollectionViewController *presentingVC = (BYSmallCollectionViewController *)[self.navigationController topViewController];
    BYSmallCollectionViewController *presentedVC = (BYSmallCollectionViewController *)[presentingVC nextViewControllerAtPoint:point];
    if (presentedVC!=nil)
    {
        [self.navigationController pushViewController:presentedVC animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - NavigationDelegate Method

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (animationController==self.transitionController) {
        return self.transitionController;
    }
    return nil;
}


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (![fromVC isKindOfClass:[UICollectionViewController class]] || ![toVC isKindOfClass:[UICollectionViewController class]])
    {
        return nil;
    }
    if (!self.transitionController.hasActiveInteraction)
    {
        return nil;
    }
    
    self.transitionController.navigationOperation = operation;
    return self.transitionController;
}

@end
