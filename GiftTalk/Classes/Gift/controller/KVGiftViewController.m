//
//  KVGiftViewController.m
//  GiftTalk
//
//  Created by kv on 15/12/9.
//  Copyright © 2015年 kv. All rights reserved.
//

#import "KVGiftViewController.h"
#import <AFNetworking.h>
#import "KVHtmlViewController.h"
#import "KVHotGiftItem.h"
#import "KVHotSubGiftItem.h"
#import "KVCollectionViewCell.h"
@interface KVGiftViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *giftDataArr;
@property(nonatomic,assign)int offset;
@end
static NSString * const ID = @"collectionView";
@implementation KVGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [KVHotSubGiftItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"Description":@"description"};
    }];
    [KVHotSubGiftItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    
    // 添加内容展示的 collectionView
    [self addCollectionView];
    
    // 获取网络数据
    [self getData];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KVCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    self.offset = 0;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
        
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.offset += 50;
        [self getData:self.offset];
        
    }];
    
}
// 上啦刷新
- (void)getData:(int)offset
{
    
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"gender"] = @"1";
    parameters[@"generation"] = @"0";
    parameters[@"limit"] = @"50";
    parameters[@"offset"] = @(offset);
    
    [manager GET:@"http://api.liwushuo.com/v2/items" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        NSArray *data = dict[@"items"];
        
        NSArray *arr = [KVHotGiftItem mj_objectArrayWithKeyValuesArray:data];
        
        for (KVHotGiftItem *item in arr) {
            [self.giftDataArr addObject:item];
        }
        
        [self.collectionView reloadData];
        
        [SVProgressHUD dismiss];
        
        [self.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)getData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //http://api.liwushuo.com/v2/items?gender=1&generation=0&limit=50&offset=0
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"gender"] = @"1";
    parameters[@"generation"] = @"0";
    parameters[@"limit"] = @"50";
    parameters[@"offset"] = @"0";

    [manager GET:@"http://api.liwushuo.com/v2/items" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        NSArray *data = dict[@"items"];
        
        _giftDataArr = [KVHotGiftItem mj_objectArrayWithKeyValuesArray:data];
        
        [self.collectionView reloadData];
        
        [SVProgressHUD dismiss];
        
        [self.collectionView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
    }];
}

// 添加 collectionView
- (void)addCollectionView
{
    // 创建六岁布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
//    flow.itemSize = CGSizeMake(100, 100);
    
    // 创建 collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flow];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor colorWithRed:200/250.0 green:200/250.0 blue:200/250.0 alpha:1];
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, navigationBarH + tabBarH + KVMargin, 0);
    //下划线的内边距
//  separatorInset = UIEdgeInsetsMake(0, 0, 0, navigationBarH + tabBarH);
    // 设置滚动条的内边距
    collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, navigationBarH + tabBarH, 0);
    
    [self.view addSubview:collectionView];
    
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KVCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - 数据源方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KVCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    KVHotGiftItem *item = self.giftDataArr[indexPath.row];
    KVHotSubGiftItem *subItem = item.data;
    cell.subItem = subItem;

    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.giftDataArr.count;
}

#pragma mark - collectionView 的代理方法
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = (GTScreenWidth - 30) / 2 ;
    CGFloat itemH = (GTScreenHeight - 64) / 3;
//    return CGSizeMake(itemW, 220);
    return CGSizeMake(itemW, itemH);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
// 监听 cell 的点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出数据模型
    KVHotGiftItem *item = self.giftDataArr[indexPath.row];
    KVHotSubGiftItem *subItem = item.data;
    
    // 创建商品详情页
    KVHtmlViewController *htmlVc = [[KVHtmlViewController alloc]init];
    htmlVc.urlStr = subItem.url;
    htmlVc.title = subItem.name;
    
    //
    [self.navigationController pushViewController:htmlVc animated:YES];
}


@end
