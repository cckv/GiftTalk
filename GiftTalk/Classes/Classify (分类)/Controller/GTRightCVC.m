//
//  GTRightCVC.m
//  GiftTalk
//
//  Created by kv on 15/12/29.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTRightCVC.h"
#import "GTRightCollectionCell.h"
#import "GTSubGiftCollectionViewController.h"
static int const headerH = 45;
static int const margin = 10;
#define itemW (GTScreenWidth * 0.8 - 40)/3
static NSString * CellIdentifier = @"UICollectionViewCell";
@interface GTRightCVC ()



// 高度累加
@property (nonatomic,assign) int sectionH;

/** 滚动到的下标 */
@property (nonatomic,assign) NSInteger sectionIndex;

@end

@implementation GTRightCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 一开始为0
    self.sectionIndex = 0;
    // 记录组数
    numberOfSections = self.kindMs.count;

    // 记录每一组头
    rowNum = 0;
    self.moveDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < numberOfSections ; i ++) {
        [self.moveDic setValue:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
    }
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];

    self.rightCollectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.8, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _rightCollectionView.backgroundColor = [UIColor whiteColor];
    _rightCollectionView.delegate = self;
    _rightCollectionView.dataSource = self;
    _rightCollectionView.showsVerticalScrollIndicator = NO;
    //  为什么底部会有一段拉不下去
    _rightCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    [self.view addSubview:_rightCollectionView];
    
//    [self.rightCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.rightCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GTRightCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    
    //注册headerView Nib的view需要继承UICollectionReusableView
    [self.rightCollectionView registerNib:[UINib nibWithNibName:@"headView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UITableViewHearderView"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetRowFromTableView:) name:@"GetRowFromTableView" object:nil];
}

// 设置 collectionView 的 frame
- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    self.rightCollectionView.frame = CGRectMake(0, 0, self.view.frame.size.width * 0.8, self.view.frame.size.height);
}


#pragma -mark UICollectionViewDelegate
// 有多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.kindMs.count;
}
// 返回每一组的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    GTCategoryItem *item = self.kindMs[section];

    return item.subcategories.count;
}

// 创建每一个 cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建 cell
    
    GTRightCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    GTCategoryItem *item = self.kindMs[indexPath.section];
    GTSubCategoryItem *subItem = item.subcategories[indexPath.row];
    cell.subItem = subItem;
//    //添加子控件
//    UIImageView *iconView = [[UIImageView alloc]init];
//    UILabel *titleLab = [[UILabel alloc]init];
//    titleLab.font = [UIFont systemFontOfSize:11];
//    titleLab.textAlignment = NSTextAlignmentCenter;
//    iconView.frame = CGRectMake(10, 0, 60, 60);
//    titleLab.frame = CGRectMake(10, 60, 60, 20);
//    // 取出模型
//    GTCategoryItem *item = self.kindMs[indexPath.section];
//    GTSubCategoryItem *subItem = item.subcategories[indexPath.row];
//    titleLab.text = subItem.name;
//    
//    [cell.contentView addSubview:iconView];
//    [cell.contentView addSubview:titleLab];
//    // 获取网络图片
//    [iconView sd_setImageWithURL:[NSURL URLWithString:subItem.icon_url] placeholderImage:[UIImage imageNamed:@"tempShop"] options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
//    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

// 每一个 cell 的大小
- (CGSize)collectionView:(UICollectionView * )collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = (GTScreenWidth * 0.8 - 40)/3;
    return CGSizeMake(w, w);
}

// collectionView 的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    return UIEdgeInsetsMake(10, 10, 10,10);
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

// 添加头部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    NSString *reuseIdentifier = @"UITableViewHearderView";
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    GTCategoryItem *item = self.kindMs[indexPath.section];
    UILabel *label = (UILabel *)[view viewWithTag:1];
    label.textAlignment = NSTextAlignmentCenter;
    UILabel *label1 = (UILabel *)[view viewWithTag:27];
    UILabel *label2 = (UILabel *)[view viewWithTag:29];
    label.text = item.name;
//    view.backgroundColor = [UIColor redColor];
    if (indexPath.section == 0) {
        label.text = nil;
        label1.hidden = YES;
        label2.hidden = YES;
    }

    return view;
}

// 头部大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={320,45};
//    return size;
    return CGSizeMake(self.rightCollectionView.bounds.size.width * 0.8, headerH);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    //    [self saveMovePoint:scrollView.contentOffset.y];
    for (NSInteger i = 0; i < self.countArr.count; i++) {
        
        id point = self.countArr[i];
        
        NSInteger num = [point integerValue];
        
        if (offsetY < num) {
            
            if ([self.delegate respondsToSelector:@selector(giftRightCVC:from:to:)]) {
                [self.delegate giftRightCVC:self from:self.sectionIndex to:i];
            }
            
            self.sectionIndex = i;
            
            break;
        }
        
        //        if (num > -scrollView.contentOffset.y) {
        //            NSLog(@"%ld",(long)i);
        //        }
        
    }
}
// 停止滑动的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    
    

 
}
- (void)test
{
//    // 滚动到指定的地方
//    //    [self moveSection:2 toSection:5];
//    // 这个方法应该用的到.
//    //    NSArray *arr =[self.rightCollectionView indexPathsForVisibleItems];
//    //    NSLog(@"%@",arr);
//#warning -----计算滚动的距离// 待完成...
//    for (int i = 0; i < self.countArr.count; i++) {
//        NSNumber *sectionH = self.countArr[i];
//        int h = sectionH.intValue;
//        if (h > scrollView.contentOffset.y) {
//            //            NSLog(@"%f",scrollView.contentOffset.y);
//            //            NSLog(@"%@---%d",sectionH,i);
//            break;//123456789
//        }else      //5.5
//        {
//            NSLog(@"%d+++",i);
//            return;
//        }
//        
//    }
//    

}
// 点击 cell 的时候调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self moveSection:indexPath.section toSection:9];
    //    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSArray *indepaths =@[indexPath];
    //    [_dataArray removeObjectAtIndex:indexPath.row];
    //    [self.BECollectionView deleteItemsAtIndexPaths:@[indexPath]];
//    NSLog(@"点击了%ld",(long)indexPath.row);
    if ([self.delegate respondsToSelector:@selector(giftRightCVC:didClick:)]) {
        [self.delegate giftRightCVC:self didClick:indexPath];
    }
}

// test
- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    NSLog(@"%s",__func__);
}
- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection
{
    NSLog(@"%s",__func__);
}
#pragma make -------获取每一组的高度
- (void)getSectionHeight
{
//    [self.countArr addObject:@(0)];
    for (int i =0; i < self.kindMs.count; i ++) {
        GTCategoryItem *item = self.kindMs[i];
        int count = (int)item.subcategories.count;
        int low = 0;
        if (count % 3 == 0) {
            low = count / 3;
        }else
        {
            low = count / 3 + 1;
        }
        self.sectionH += (headerH + itemW * low + margin * (low + 1));
        
        [self.countArr addObject:@(_sectionH)];
    }
//    NSLog(@"%@",self.countArr);
}

#pragma make -----懒加载-------
- (NSMutableArray *)countArr
{
    if (_countArr == nil) {
        _countArr = [NSMutableArray array];
    }
    return _countArr;
}

#pragma make -------获取数据刷新列表
- (void)setKindMs:(NSArray *)kindMs
{
    _kindMs = kindMs;
    [self.rightCollectionView reloadData];
    [self getSectionHeight];
}
@end
