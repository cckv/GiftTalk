//
//  KVHaitaoViewController.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//
//http://api.liwushuo.com/v2/channels/129/items?ad=1&gender=1&generation=0&limit=20&offset=0
#import "KVNewlifeViewController.h"
#import "KVHtmlViewController.h"
#import "KVHomeCell.h"
#import "KVHomeCellItem.h"


@interface KVNewlifeViewController ()
@property (nonatomic,strong) NSMutableArray *cellDataArr;
@property(nonatomic,assign)int offset;
@end

@implementation KVNewlifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 设置属性
    [self initView];
    
    // 数据的加载
    [self getData];
    
    self.offset = 0;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.offset += 20;
        [self getData:self.offset];
        
    }];
    
}
// 上啦刷新
- (void)getData:(int)offset
{
    
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //    NSString *urlStr = @"http://api.liwushuo.com/v2/channels/106/items?ad=1&gender=1&generation=0&limit=20&offset=0";
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/118/items?ad=1&gender=1&generation=0&limit=20&offset=%d",offset];
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        
        NSDictionary *data = responseObject[@"data"];
        
        NSArray *items = data[@"items"];
        
        NSArray *arr = [KVHomeCellItem mj_objectArrayWithKeyValuesArray:items];
        
        for (KVHomeCellItem *item in arr) {
            [self.cellDataArr addObject:item];
        }
        
        [self.tableView reloadData];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [SVProgressHUD dismiss];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)getData
{
    
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSString *urlStr = @"http://api.liwushuo.com/v2/channels/118/items?ad=1&gender=1&generation=0&limit=20&offset=0";
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        
        NSDictionary *data = responseObject[@"data"];
        
        NSArray *items = data[@"items"];
        
        
        _cellDataArr = [KVHomeCellItem mj_objectArrayWithKeyValuesArray:items];
        
        [self.tableView reloadData];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.cellDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KVHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    
    KVHomeCellItem *item = self.cellDataArr[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KVHtmlViewController *htmlVc = [[KVHtmlViewController alloc]init];
    
    KVHomeCellItem *item = self.cellDataArr[indexPath.row];
    htmlVc.urlStr = item.url;
    htmlVc.title = @"攻略详情";
    
    [self.navigationController pushViewController:htmlVc animated:YES];
}
- (void)initView
{
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, navigationBarH +tabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KVHomeCell class]) bundle:nil] forCellReuseIdentifier:@"homeCell"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [KVHomeCellItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [KVHomeCellItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"Template":@"template"};
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"timo" object:nil];
}
@end
