//
//  GTSubCategoryViewController.m
//  GiftTalk
//
//  Created by kv on 15/12/25.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTSubCategoryViewController.h"
#import "GTGiftLeftTVC.h"
#import "GTRightCVC.h"
#import "GTSelectGiftVC.h"
#import "GTSubGiftCollectionViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#import "GTLeftCell.h"
#import "KVSelButton.h"

@interface GTSubCategoryViewController()<UITableViewDelegate,GTRightVCVDelegate,GTGiftLeftTVCDelegate>
/**
 *  数据模型数组
 */
@property (nonatomic,strong) NSArray *kindMs;
/**
 *  顶部的选择按钮
 */
@property (nonatomic, strong) KVSelButton *topButton;
/**
 *  左边的 tableViewVC
 */
@property (nonatomic,strong) GTGiftLeftTVC *leftTVC;
/**
 *  右边的 tableViewVC
 */
@property (nonatomic,strong)  GTRightCVC *rightCVC;

@end

@implementation GTSubCategoryViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//     获取网络数据

    [self kindMs];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置代理
    self.rightCVC.delegate = self;
    self.leftTVC.delegate = self;
    
    [GTCategoryItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [GTSubCategoryItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    
    self.view.backgroundColor = [UIColor grayColor];
//    [self getData];
    [self setViews];
//    self.kindMs;
    // 一开始左边的 tableView 选中第一个 cell
//    [self giftRightCVC:self.rightCVC from:0 to:0];
}


// 把头部按钮添加到 view 上去
- (void)setViews
{
    [self.view addSubview:self.topButton];
    self.topButton.frame = CGRectMake(0, 0, GTScreenWidth, GTScreenHeight * 0.05);

}
// 获取分类礼物界面数据
// 获取到数据后给左右两边的 view 赋值
- (NSArray*)getData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://api.liwushuo.com/v2/item_categories/tree?" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSDictionary *data = dict[@"data"];
        NSArray *categories = data[@"categories"];
        
        _kindMs = [GTCategoryItem mj_objectArrayWithKeyValuesArray:categories];
        
        self.leftTVC.kindMs = _kindMs;
        [self.leftTVC.tableView reloadData];
        self.rightCVC.kindMs = _kindMs;
//        [self.rightCVC.collectionView reloadData];
        [self addLeftView];
//        [self addRightView];
        [self addRV];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    return _kindMs;
}

// 添加右边的 collectionView
- (void)addRV
{
    [self.view addSubview:self.rightCVC.view];
    self.rightCVC.view.frame = CGRectMake(GTScreenWidth * 0.2, GTScreenHeight * 0.05, GTScreenWidth * 0.8,GTScreenHeight * 0.95 - 49);
}

// 添加左边的tableView
- (void)addLeftView
{
    [self.view addSubview:self.leftTVC.tableView];
    self.leftTVC.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.leftTVC.tableView.frame = CGRectMake(0, GTScreenHeight * 0.05, GTScreenWidth * 0.2,GTScreenHeight * 0.95 - 49);
}


// 点击头部的按钮跳转到选礼神器页面
- (void)topBtnClick
{
    GTSelectGiftVC *selGiftVC = [[GTSelectGiftVC alloc]init];
    [self.navigationController pushViewController:selGiftVC animated:YES];
}

#pragma mark 右边 tableView 的代理方法---
// 点击右边的 cell 跳转到对应的礼物页面
- (void)giftRightCVC:(GTRightCVC *)rightCVC didClick:(NSIndexPath *)indexPath
{
    GTSubGiftCollectionViewController *subVC = [[GTSubGiftCollectionViewController alloc]init];
    GTCategoryItem *item = self.kindMs[indexPath.section];
    GTSubCategoryItem *subItem = item.subcategories[indexPath.row];
    subVC.subItem = subItem;
    [self.navigationController pushViewController:subVC animated:YES];
}

#pragma mark 左边 tableVIew 的代理方法------------

// 点击左边的 cell, 右边的 collectionView 移动到相应的位置并且刷新数据
- (void)giftLeftTVC:(GTGiftLeftTVC *)leftTVC didClickCellIndex:(NSInteger)index
{
//    [self rightCVC:self.rightCVC from:1 to:index];
//    [self.rightCVC.rightCollectionView reloadData];
    if (index == 0)return;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.rightCVC.rightCollectionView.contentOffset = CGPointMake(0, [self.rightCVC.countArr[index - 1] integerValue]);
    }];
}

#pragma mark - 右边 view 代理方法

// 右边滚动左边做出相应的动作
- (void)giftRightCVC:(GTRightCVC *)rightCVC from:(NSInteger)from to:(NSInteger)to
{

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:to inSection:0];
    
    // 这个方法就是移动 cell
    // scrollViewPosition 表示选中cell 的位置

    [self.leftTVC.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    GTLeftCell *cell = [self.leftTVC.tableView cellForRowAtIndexPath:indexPath];
        
    // 选中
    self.leftTVC.selectCell.titleLab.textColor = [UIColor blackColor];
//    GTLeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.titleLab.textColor = [UIColor redColor];
    self.leftTVC.selectCell = cell;


}

#pragma make 懒加载-------------
// 数据源
- (NSArray *)kindMs
{
    if (_kindMs == nil) {
        _kindMs = [self getData];
    }
    return _kindMs;
}
// 左边的 tableView 控制器
- (GTGiftLeftTVC *)leftTVC
{
    if (_leftTVC == nil) {
        _leftTVC = [[GTGiftLeftTVC alloc]init];
        _leftTVC.tableView.showsVerticalScrollIndicator = NO;
    }
    return _leftTVC;
}
// 右边的 collectionView 控制器
- (GTRightCVC *)rightCVC
{
    if (_rightCVC == nil) {
        _rightCVC = [[GTRightCVC alloc]init];
        
    }
    return _rightCVC;
}

// 头部的按钮
- (KVSelButton *)topButton
{
    if (_topButton == nil) {
        _topButton = [[KVSelButton alloc]init];
        
        // 设置按钮的属性
        [_topButton setTitle:@"选礼神器" forState:UIControlStateNormal];
        [_topButton setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]];
        [_topButton setImage:[UIImage imageNamed:@"giftCategory_guide"] forState:UIControlStateNormal];
//        _topButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _topButton.titleLabel.font = [UIFont setFontSize];
        [_topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 给按钮添加点击事件
        [_topButton addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 调整按钮 title 的位置
        _topButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, GTScreenWidth/5 * 3);
        _topButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }
    return _topButton;
}
@end
