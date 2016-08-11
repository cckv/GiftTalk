//
//  GTSelectGiftVC.m
//  GiftTalk
//
//  Created by kv on 15/12/30.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTSelectGiftVC.h"
#import "GTFilterItem.h"
#import "GTHeadDataItem.h"
#import "GTCategoryView.h"
#import "GTSelGiftItem.h"

#import "KVSelCollectionViewCell.h"

#import "KVHtmlViewController.h"
#define buttonW (GTScreenWidth - 40)/3

@interface GTSelectGiftVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GTCategoryViewDelegate>

@property (strong, nonatomic)UICollectionView *collectionView;
/*
 * 头部视图的数据
 */
@property (nonatomic,strong) NSArray *headData;
/*
 * collectionView的数据
 */
@property (nonatomic,strong) NSArray *contentData;
// 记录当前选中的按钮
@property (nonatomic,weak) UIButton *selectBtn;
/*
 * 弹出来的选择分类的按钮的 view
 */
@property (nonatomic,strong) GTCategoryView *categoryView;
/*
 * 蒙版
 */
@property (nonatomic,strong) UIButton *coverView;
/*
 * 头部视图
 */
@property (nonatomic,strong) UIView *topView;

@property (nonatomic,weak) AFHTTPSessionManager *manager;
@end

static NSString * const ID = @"selCollctionCell";

@implementation GTSelectGiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选礼神器";
    
    // 获取网络数据
    [self getData];
    
//    self.contentData;
    [self getContentData];
    // 添加影藏这的,包含分类类别的 view
//    [self.view addSubview:self.categoryView];
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    // 模型关键字的替换
    [GTHeadDataItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [GTFilterItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [GTSelGiftItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
    [GTSelGiftItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"Description":@"description"};
    }];
    

}
// 退出控制器取消弹框和网络数据的加载
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

// 获取collectionView 的网络数据
- (NSArray *)getContentData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    
    // 获取 collectionView 的数据
    [self.manager GET:@"http://api.liwushuo.com/v2/search/item_by_type?limit=20&offset=0" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSDictionary *data = dict[@"data"];
        NSArray *items = data[@"items"];
        _contentData = [GTSelGiftItem mj_objectArrayWithKeyValuesArray:items];

        [self.collectionView reloadData];

        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showWithStatus:@"网络数据加载失败!"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
        
        
    }];
    return _contentData;
}
// 获取分类礼物界面数据
- (NSArray*)getData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 获取头部视图的数据
    [self.manager GET:@"http://api.liwushuo.com/v2/search/item_filter?" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSDictionary *data = dict[@"data"];
        NSArray *filters = data[@"filters"];
        _headData = [GTHeadDataItem mj_objectArrayWithKeyValuesArray:filters];
        
        // 设置 collectionView 的属性
        [self setCollectionView];
        // 添加 collectionView
        [self.view addSubview:self.collectionView];
        // 添加蒙版
        [self.view addSubview:self.coverView];
        // 添加头部视图
        [self.view addSubview:self.topView];
        // 添加头部视图里面的按钮
        [self addTopViewBtn];
        // 添加头部隐藏的选择分类的 view
        [self.view addSubview:self.categoryView];
        
        // 注册 cell
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KVSelCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
        
        [self.collectionView reloadData];

        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    return _headData;
}

// 添加头部按钮的 view
- (void)addTopViewBtn
{
    CGFloat btnW = GTScreenWidth / 4;
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        GTHeadDataItem *item = self.headData[i];
        
        // 设置按钮的属性(文字,字体颜色)
        [btn setTitle:item.name forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnW * i, 0, btnW, 30);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.topView addSubview:btn];
        
        // 监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    }
}

// 头部按钮的点击
- (void)btnClick:(UIButton*)btn
{
    GTHeadDataItem *item = self.headData[btn.tag];
    self.categoryView.item = item;
//    self.selectBtn = btn;
//    btn.selected = !btn.selected;
        if(self.selectBtn == btn)
        {
            btn.selected = !btn.selected;
            if (self.selectBtn.selected) {
                [self showView];
            }else
            {
                [self hideCover];
            }
            return;
        }else
        {
            if (self.selectBtn.selected) {
                [self showView];
            }else
            {
                [self hideCover];
            }
        }
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;

}

// 设置礼物展示的 collectionView
- (void)setCollectionView
{
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    CGRect frame = CGRectMake(0, 30, GTScreenWidth, GTScreenHeight - 30);
    self.collectionView=[[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]];
    
    //注册Cell，必须要有
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KVSelCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

#pragma mark - UICollectionViewDelegate----

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contentData.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    KVSelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    GTSelGiftItem *item = self.contentData[indexPath.row];
    
    cell.item = item;
    

    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = (GTScreenWidth - 30) / 2 ;
    CGFloat itemH = (GTScreenHeight - 64) / 3;
    //    return CGSizeMake(itemW, 220);
    return CGSizeMake(itemW, itemH);
//    return CGSizeMake(170, 250);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTSelGiftItem *item = self.contentData[indexPath.row];
    
    // 跳转的控制器
    KVHtmlViewController *htmlVc = [[KVHtmlViewController alloc]init];
    htmlVc.title = item.name;
    
    [self.navigationController pushViewController:htmlVc animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma make categoryView 的代理方法
- (void)categoryView:(GTCategoryView *)categoryView didClick:(UIButton *)btn
{
    // 1.获取按钮的 title
    NSLog(@"%@",btn.titleLabel.text);
    // 2.根据按钮的 title找到相对应的数据
    
    // 3.刷新 collectionView
    // 4.移除蒙版
    [self hideCover];
}

#pragma make -----懒加载
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSArray *)contentData
{
    if (_contentData == nil) {
        _contentData = [self getContentData];
    }
    return _contentData;
}
- (NSArray *)headData
{
    if (_headData == nil) {
        _headData = [self getData];
    }
    return _headData;
}

// 头部影藏的包含类别的 view
- (GTCategoryView *)categoryView
{
    if (_categoryView == nil) {
        CGRect frame = CGRectMake(0, -160, GTScreenWidth, 160);
        _categoryView = [[GTCategoryView alloc]initWithFrame:frame];
        _categoryView.backgroundColor = [UIColor grayColor];
        _categoryView.delegate = self;
    }
    return _categoryView;
}

// 点击按钮后弹出来的遮盖
- (UIButton *)coverView
{
    if (_coverView == nil) {
        _coverView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, GTScreenWidth, GTScreenHeight)];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.6;
        _coverView.hidden = YES;
        [_coverView addTarget:self action:@selector(hideCover) forControlEvents:UIControlEventTouchDown];
    }
    return _coverView;
}

// 点击蒙版影藏
- (void)hideCover
{
    self.coverView.hidden = YES;
    CGRect frame = self.categoryView.frame;
    frame.origin.y = -200;
    self.categoryView.frame = frame;
    self.selectBtn.selected = NO;
}
// 展示蒙版和 categoryView
- (void)showView
{
    self.coverView.hidden = NO;
    CGRect frame = self.categoryView.frame;
    frame.origin.y = 30;
    self.categoryView.frame = frame;
    

}
// 头部包含按钮的 view
- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.frame = CGRectMake(0, 0, GTScreenWidth, 30);
      
    }
    return _topView;
}
@end
