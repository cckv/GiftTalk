//
//  GTClassifyViewController.m
//  GiftTalk
//
//  Created by 罗平 on 15/12/9.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTClassifyViewController.h"
#import "GTTacticViewController.h"
#import "GTSubCategoryViewController.h"
@interface GTClassifyViewController ()
@property (nonatomic,weak) UISegmentedControl *segmentControl;
@end

@implementation GTClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // 添加 segmentControl
    [self addSegment];
    // 添加两个控制器
    [self setChildVC];
    // 点击 segment 切换控制器
    [self selView];
    
    [self setNav];
}
- (void)setNav
{
    UIButton *left = [[UIButton alloc]init];
    [left sizeToFit];
    [left setImage:[UIImage imageNamed:@"search_new"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftMsgBtn = [[UIBarButtonItem alloc] initWithCustomView:left];
    [self.navigationItem setRightBarButtonItem:leftMsgBtn];
}
// 搜索按钮的点击
- (void)search
{
    KVSearchTableViewController *searchVC = [[KVSearchTableViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [SVProgressHUD dismiss];
}
- (void)addSegment
{
    NSArray *arr = @[@"攻略",@"礼物"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:arr];
    self.segmentControl = segmentControl;
    segmentControl.frame = CGRectMake(0, 0, 180, 30);
    self.navigationItem.titleView = segmentControl;
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [segmentControl setTintColor:[UIColor whiteColor]];
}
- (void)segClick:(UISegmentedControl*)segmentcontrol
{
    //    NSLog(@"%ld",(long)segmentcontrol.selectedSegmentIndex);
    
    [self selView];
}
- (void)selView
{
    UIViewController *vc = self.childViewControllers[self.segmentControl.selectedSegmentIndex];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    //    if (vc.isViewLoaded) return;
    
    vc.view.frame = self.view.bounds;
    
    [self.view addSubview:vc.view];
}
- (void)setChildVC
{
    // 添加攻略
    GTTacticViewController *tactic = [[GTTacticViewController alloc]init];
    [self addChildViewController:tactic];
    
    // 添加礼物
    GTSubCategoryViewController *gift = [[GTSubCategoryViewController alloc]init];
    //    KVGift1ViewController *gift = [[KVGift1ViewController alloc]init];
    [self addChildViewController:gift];
    
}

@end
