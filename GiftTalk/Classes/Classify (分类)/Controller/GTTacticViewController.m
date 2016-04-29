//
//  GTTacticViewController.m
//  GiftTalk
//
//  Created by kv on 15/12/25.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTTacticViewController.h"
#import "KVTacticItem.h"
#import "NSDictionary+PropertyCode.h"
#import "KVTacticItem.h"
#import "KVSubTacticItem.h"
#import "KVTacticCell.h"
#import "KVTacticDetailViewController.h"
#import "KVCollectionReusableView.h"

static NSString * const ID = @"tacticCell";
@interface GTTacticViewController()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,weak) UICollectionView *collectionView;
@end

@implementation GTTacticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    // 获取数据
    [self getData];
    // 初始化设置属性
    [self initSetting];
    // 添加 collectionView
    [self addCollectionView];
    
}
- (void)addCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // 添加到 view 上
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KVTacticCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    //注册headerView Nib的view需要继承UICollectionReusableView
    [collectionView registerNib:[UINib nibWithNibName:@"headView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UITableViewHearderView"];
    
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, tabBarH + KVMargin, 0);
    // 滚动条的内边距
    collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, tabBarH + KVMargin, 0);
    
}
#pragma mark - UICollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    KVTacticItem *item = self.dataArr[section];
    return item.channels.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KVTacticCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    KVTacticItem *item = self.dataArr[indexPath.section];
    KVSubTacticItem *subItem = item.channels[indexPath.row];
    
    cell.subItem = subItem;
    
    return cell;
}
// 每一个 cell 的大小
- (CGSize)collectionView:(UICollectionView * )collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = (GTScreenWidth - 80)/4;
    return CGSizeMake(w, w);
}
// collectionView 的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    return UIEdgeInsetsMake(10, 10, 10,10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出数据
    KVTacticItem *item = self.dataArr[indexPath.section];
    KVSubTacticItem *subItem = item.channels[indexPath.row];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%ld/items?ad=1&limit=20&offset=0",(long)subItem.ID];
    
    KVTacticDetailViewController *tacticDetailVc = [[KVTacticDetailViewController alloc]init];
    tacticDetailVc.urlStr = urlStr;
    tacticDetailVc.title = subItem.name;
    [self.navigationController pushViewController:tacticDetailVc animated:YES];
}
// 添加头部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = @"UITableViewHearderView";
    
    KVCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    if (indexPath.section == 0) {
        view.name = @"品类";
    }else if (indexPath.section == 1)
    {
        view.name = @"对象";
    }else if(indexPath.section == 2)
    {
        view.name = @"场合";
    }else if(indexPath.section == 3)
    {
        view.name = @"风格";
    }
    
    view.backgroundColor = [UIColor grayColor];
    
    return view;
}
// 头部大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    //    CGSize size={320,45};
    //    return size;
    return CGSizeMake( GTScreenWidth, 2 * KVMargin);
}
- (void)getData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSString *urlStr = @"http://api.liwushuo.com/v2/channel_groups/all?";
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        
        NSDictionary *data = responseObject[@"data"];

        NSArray *channels = data[@"channel_groups"];

        _dataArr = [KVTacticItem mj_objectArrayWithKeyValuesArray:channels];


//        NSLog(@"获取数据成功");
        [self.collectionView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];

    }];
}
- (void)initSetting
{
    [KVSubTacticItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [KVTacticItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
}
@end
