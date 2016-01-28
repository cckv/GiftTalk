//
//  KVTacticDetailViewController.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVTacticDetailViewController.h"

#import "KVHtmlViewController.h"

#import "NSDictionary+PropertyCode.h"
#import "KVTacticDetailItem.h"
#import "KVTacticDetailCell.h"

@interface KVTacticDetailViewController ()
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation KVTacticDetailViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    
    
    
    return [super initWithCollectionViewLayout:flowlayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
//    [self.collectionView registerClass:[KVTacticDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KVTacticDetailCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [KVTacticDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [KVTacticDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"Template":@"template"};
    }];
}

- (void)getData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    
//    NSString *urlStr = @"http://api.liwushuo.com/v2/channels/129/items?ad=1&gender=1&generation=0&limit=20&offset=0";
    
    [manager GET:self.urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        NSLog(@"%@获取数据成功",self.class);
        NSDictionary *data = responseObject[@"data"];
//
        NSArray *items = data[@"items"];
        

        _dataArr = [KVTacticDetailItem mj_objectArrayWithKeyValuesArray:items];
//        
//        _cellDataArr = [KVHomeCellItem mj_objectArrayWithKeyValuesArray:items];
//        
        [self.collectionView reloadData];
//        NSLog(@"%ld",_dataArr.count);
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.dataArr.count;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(GTScreenWidth - 20, 160);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

// 创建每一个 cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KVTacticDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    KVTacticDetailItem *item = self.dataArr[indexPath.row];
    cell.item = item;

    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建展示攻略详情的控制器
    KVHtmlViewController *htmlVc = [[KVHtmlViewController alloc]init];
    
    // 取出数据
    KVTacticDetailItem *item = self.dataArr[indexPath.row];
    htmlVc.urlStr = item.url;
    htmlVc.title = item.title;
    //
    [self.navigationController pushViewController:htmlVc animated:YES];
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
