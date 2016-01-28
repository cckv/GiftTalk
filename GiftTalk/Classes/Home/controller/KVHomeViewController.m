//
//  KVHomeViewController.m
//  GiftTalk
//
//  Created by kv on 15/12/9.
//  Copyright © 2015年 kv. All rights reserved.
//

#import "KVHomeViewController.h"
#import "KVTitleButton.h"

#import "KVEssionViewController.h"
#import "KVHaitaoViewController.h"
#import "KVLearnViewController.h"
#import "KVNewlifeViewController.h"
#import "KVCommentViewController.h"


#define titleButtonW 80
#define titleBtnCount 5
static int const titleViewH = 30;
@interface KVHomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *titleView;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) KVTitleButton *selTitleButton;
@property (nonatomic,weak) UIView *bottomLine;
@end

@implementation KVHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加包含自控制器的 scrollView
    [self setScrollView];
    
    // 添加头部按钮的 scrollView
    [self setTitleView];
    
    // 添加头部的下划线
    [self addBottomLine];
    
    // 添加自控制器
    [self addChildVc];
}

#pragma mark - 初始化方法
- (void)addChildVc
{
    [self addChildViewController:[[KVEssionViewController alloc]init]];
    [self addChildViewController:[[KVHaitaoViewController alloc]init]];
    [self addChildViewController:[[KVLearnViewController alloc]init]];
    [self addChildViewController:[[KVNewlifeViewController alloc]init]];
    [self addChildViewController:[[KVCommentViewController alloc]init]];
    
    // 内容大小
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.scrollView.width, 0);
    // 不要自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 默认添加第0个子控制器view到scrollView
    [self addChildVcViewIntoScrollView:0];
}
- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.view.superview) return;
    
    [self.scrollView addSubview:childVc.view];
    
    childVc.view.x = index*GTScreenWidth;
    childVc.view.y = 0;
    childVc.view.width = self.scrollView.width;
    childVc.view.height = self.scrollView.height;
    
}
- (void)addBottomLine
{
    
//    CGRect rect = CGRectMake(0, titleViewH - 2, 60, 2);
    UIView *bottomLine = [[UIView alloc]init];
    [self.titleView addSubview:bottomLine];
    _bottomLine = bottomLine;
    bottomLine.height = 2;
    bottomLine.y = titleViewH - 2;
    bottomLine.backgroundColor = [UIColor redColor];
    
    KVTitleButton *firstButton = self.titleView.subviews[0];
//    [self titleBtnClick:firstButton];// 默认选中第一个按钮
    // 改变按钮状态
    firstButton.selected = YES; // UIControlStateSelected
    self.selTitleButton = firstButton;
    
    [firstButton.titleLabel sizeToFit]; // 主动根据文字内容计算按钮内部label的大小
    // 下划线宽度 == 按钮内部文字的宽度
    bottomLine.width = firstButton.titleLabel.width + 10;
    // 下划线中心点x
    bottomLine.centerX = firstButton.centerX;

    
}
// 添加 titleView
- (void)setTitleView
{
    UIScrollView *titleView = [[UIScrollView alloc]init];
    [self.view addSubview:titleView];
    _titleView = titleView;
    titleView.frame = CGRectMake(0, 0, GTScreenWidth, 30);
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    titleView.contentSize = CGSizeMake(titleBtnCount * titleButtonW, 0);
    
    // 添加按钮
    [self addTitleButton];
    
    // 设置左右不可滚动
    titleView.showsHorizontalScrollIndicator = NO;
}

// 添加滚动的 scrollView
- (void)setScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    scrollView.frame = self.view.bounds;
    
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    scrollView.pagingEnabled = YES;
}
- (void)addTitleButton
{
    NSArray *titleArr = @[@"精选",@"海淘",@"礼物",@"美食",@"数码",@"家居",@"运动",@"爱运动",@"生日",@"科技范",@"家居",@"设计感",@"礼物",@"送基友",@"送爸妈",@"送女票",@"爱动漫"];
    for (int i = 0; i < titleBtnCount; i++) {
        KVTitleButton *titleBtn = [[KVTitleButton alloc]init];
        [self.titleView addSubview:titleBtn];
        titleBtn.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, _titleView.height);
        titleBtn.tag = i;
        
        // 设置按钮的文字,颜色
        [titleBtn setTitle:titleArr[i] forState:UIControlStateNormal];

        // 添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
}

#pragma mark - 监听事件

- (void)titleBtnClick:(KVTitleButton *)titleBtn
{
    self.selTitleButton.selected = NO;
    titleBtn.selected = YES;
    self.selTitleButton = titleBtn;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        // 设置下划线的 frame
        self.bottomLine.width = titleBtn.titleLabel.width + 10;
        self.bottomLine.centerX = titleBtn.centerX;
        
        // 添加 view
        CGFloat x = titleBtn.tag * GTScreenWidth;
        
        self.scrollView.contentOffset = CGPointMake(x, 0);
    }];
    
    [self addChildVcViewIntoScrollView:titleBtn.tag];
    
    
    
}

#pragma mark - 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;

    NSInteger index = offsetX / GTScreenWidth;
    KVTitleButton *titleBtn = self.titleView.subviews[index];
    [self titleBtnClick:titleBtn];
}
@end
