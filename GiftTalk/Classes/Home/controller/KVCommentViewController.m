//
//  KVHaitaoViewController.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//
//http://api.liwushuo.com/v2/channels/129/items?ad=1&gender=1&generation=0&limit=20&offset=0
#import "KVCommentViewController.h"
#import "KVHtmlViewController.h"
#import "KVHomeCell.h"
#import "KVHomeCellItem.h"


@interface KVCommentViewController ()
@property (nonatomic,strong) NSArray *cellDataArr;
@end

@implementation KVCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置属性
    [self initView];
    
    // 数据的加载
    [self getData];
    
}

- (void)getData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"http://api.liwushuo.com/v2/channels/121/items?ad=1&gender=1&generation=0&limit=20&offset=0";
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        
        NSDictionary *data = responseObject[@"data"];
        
        NSArray *items = data[@"items"];
        
        
        _cellDataArr = [KVHomeCellItem mj_objectArrayWithKeyValuesArray:items];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
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
@end
