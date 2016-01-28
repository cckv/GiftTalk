//
//  KVTabBarViewController.m
//  GiftTalk
//
//  Created by kv on 15/12/9.
//  Copyright © 2015年 kv. All rights reserved.
//

#import "KVTabBarViewController.h"
#import "KVMeViewController.h"
#import "KVHomeViewController.h"
#import "KVGiftViewController.h"
#import "KVNavigationController.h"
#import "KVMeNavigationController.h"
#import "KVTabBar.h"
#import "GTClassifyViewController.h"

#define KVColor1  [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1]
@interface KVTabBarViewController ()<KVTabBarDelegate>
@property (nonatomic,strong) NSMutableArray *itemArrary;
@end

@implementation KVTabBarViewController
- (NSMutableArray *)itemArrary
{
    if (_itemArrary == nil) {
        _itemArrary = [NSMutableArray array];
    }
    return  _itemArrary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVC];
    
    [self setTabBar];
}
- (void)setTabBar
{
//    [self.tabBar removeFromSuperview];
    KVTabBar *myTabBar = [[KVTabBar alloc]initWithFrame:self.tabBar.bounds];
    myTabBar.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:myTabBar];
    myTabBar.itemArr = self.itemArrary;
    myTabBar.delegate = self;
    // 添加顶部的一条线
//    UIView *topLine = [[UIView alloc]init];
//    [self.view addSubview:topLine];
//    topLine.frame = CGRectMake(0, self.view.bounds.size.height - myTabBar.bounds.size.height, self.view.bounds.size.width, 1);
//    topLine.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[KVTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}
- (void)tabBar:(KVTabBar *)tabBar didClickBtnFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}
- (void)addChildVC
{
    // 首页
    KVHomeViewController *home = [[KVHomeViewController alloc]init];
    home.title = @"礼物说";
    [self setChildVC:home withIma:[UIImage imageNamed:@"TabBar_home"] selectIma:[UIImage imageNamed:@"TabBar_home_selected"]];
    // 热门
    KVGiftViewController *gift = [[KVGiftViewController alloc]init];
    gift.title = @"热门";
    [self setChildVC:gift withIma:[UIImage imageNamed:@"TabBar_gift"] selectIma:[UIImage imageNamed:@"TabBar_gift_selected"]];
    // 分类
//    KVCategoryViewController *category = [[KVCategoryViewController alloc]init];
    GTClassifyViewController *category = [[GTClassifyViewController alloc]init];
    category.title = @"分类";
    [self setChildVC:category withIma:[UIImage imageNamed:@"TabBar_category"] selectIma:[UIImage imageNamed:@"TabBar_category_Selected"]];
    // 我
    KVMeViewController *me = [[KVMeViewController alloc]init];
//    me.title = @"我";
    me.tabBarItem.title = @"我";
    [self setChildVC:me withIma:[UIImage imageNamed:@"TabBar_me_boy"] selectIma:[UIImage imageNamed:@"TabBar_me_boy_selected"]];
    
}
- (void)setChildVC:(UIViewController*)childVC withIma:(UIImage*)image selectIma:(UIImage*)selIma
{
    childVC.view.backgroundColor = KVColor1;
    childVC.tabBarItem.image = image;
    childVC.tabBarItem.selectedImage = selIma;

    [self.itemArrary addObject:childVC.tabBarItem];
    
    
    if ([childVC isKindOfClass:[KVMeViewController class]]) {
        KVMeNavigationController *nav = [[KVMeNavigationController alloc]initWithRootViewController:childVC];
        [self addChildViewController:nav];
    }else
    {
        KVNavigationController *nav = [[KVNavigationController alloc]initWithRootViewController:childVC];
        [self addChildViewController:nav];
    }
    
}


@end
