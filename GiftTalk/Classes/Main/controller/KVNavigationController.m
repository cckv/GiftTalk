//
//  KVNavigationController.m
//  GiftTalk
//
//  Created by kv on 15/12/9.
//  Copyright © 2015年 kv. All rights reserved.
//

#import "KVNavigationController.h"
#import "UIImage+Image.h"

@interface KVNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KVNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
//    [UINavigationBar appearance];
    // 设置导航栏的图片
    [self setUp];
    
    // 设置侧滑返回手势
    self.interactivePopGestureRecognizer.delegate = self;
}
- (void)setUp
{
    // 设置导航栏的图片
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [navigationBar setBackgroundColor:[UIColor redColor]];
    [navigationBar setBackgroundImage:[UIImage imageWithColor:KVColor(243, 53, 62)] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏文字的大小和颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navigationBar setTitleTextAttributes:dict];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationButtonReturn"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}
// 侧滑手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.childViewControllers.count == 0) {
//    }else
//    {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}
//- (void)back
//{
//    [self popoverPresentationController];
//}
@end
