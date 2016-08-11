//
//  GTSubGiftCollectionViewController.m
//  GiftTalk
//
//  Created by kv on 15/12/30.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTSubGiftCollectionViewController.h"
#import "NSDictionary+PropertyCode.h"
#import "GTGiftDetailItem.h"
#import "KVHtmlViewController.h"

#import "KVSubGiftCollectionViewCell.h"

@interface GTSubGiftCollectionViewController ()
@property(nonatomic,assign)int offset;
@property (nonatomic,strong) NSMutableArray *itemMs;

@end

@implementation GTSubGiftCollectionViewController

static NSString * const reuseIdentifier = @"giftDetailCell";


- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(160, 160);
    return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取网络数据
    [self getData:0];

    // 设置滚动条隐藏
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    // 设置 collectionView 的背景颜色
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // 模型特俗字符的替换
    [GTGiftDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [GTGiftDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"Description":@"description"};
    }];
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KVSubGiftCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    
    self.offset = 0;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData:self.offset];
        
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.offset += 50;
        [self getData:self.offset];
        
    }];
    
}

// 获取网络数据
- (NSArray*)getData:(int)offset
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    GTSubCategoryItem *subItem = self.subItem;
    NSLog(@"%ld",subItem.ID);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *urlStr = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/item_subcategories/%ld/items?limit=20&offset=%d",(long)subItem.ID,offset];

    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSDictionary *data = dict[@"data"];
        NSArray *items = data[@"items"];
        
        NSArray *arr = [GTGiftDetailItem mj_objectArrayWithKeyValuesArray:items];
        
        [self.itemMs addObjectsFromArray:arr];
        
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
        if (self.offset == 0) {
            
            [self.collectionView.mj_header endRefreshing];
        }else
        {
            [self.collectionView.mj_footer endRefreshing];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.offset == 0) {
            
            [self.collectionView.mj_header endRefreshing];
        }else
        {
            [self.collectionView.mj_footer endRefreshing];
        }
        
    }];
    return _itemMs;
}

#pragma mark <UICollectionViewDataSource>
//
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.itemMs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建 cell
    KVSubGiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 取出数据模型
    GTGiftDetailItem *item = self.itemMs[indexPath.row];
    
    cell.item = item;
    
    // 设置背景颜色
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake(170, 250);
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
    KVHtmlViewController *htmlVc = [[KVHtmlViewController alloc]init];
    
    // 取出数据模型
    GTGiftDetailItem *item = self.itemMs[indexPath.row];
    htmlVc.urlStr = item.url;
    [self.navigationController pushViewController:htmlVc animated:YES];
}

#pragma make -------懒加载
// 数据模型的加载
- (NSMutableArray *)itemMs
{
    if (_itemMs == nil) {
        _itemMs = [NSMutableArray array];
    }
    return _itemMs;
}
@end
