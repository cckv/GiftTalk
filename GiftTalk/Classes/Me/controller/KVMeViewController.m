//
//  KVMeViewController.m
//  GiftTalk
//
//  Created by kv on 15/12/9.
//  Copyright © 2015年 kv. All rights reserved.
//



// 沙盒的位置
//NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]);


#import "KVMeViewController.h"

#import "KVNavigationController.h"
#import "KVLoginViewController.h"

#import "KVSettingViewController.h"

@interface KVMeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconH;
@property (weak, nonatomic) IBOutlet UIView *gtView;

@property (nonatomic,weak) UIView *redLine;

@property (nonatomic,strong) NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UIButton *iconImageView;

@end

static NSString *const ID = @"cell";

@implementation KVMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // 设置导航栏的按钮
    [self setNavigationBar];
    
    // 设置头像为圆形
    [self setIcon];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(300, 0, 44, 0);
    // 注册 cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    // 选中喜欢的礼物
    [self gift_like:nil];
    
    // 设置红色的下划线
    [self setRedLine];
    
}

// 设置头像为圆形
- (void)setIcon
{
    self.iconImageView.layer.cornerRadius = self.iconImageView.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
}

// 设置红色的下划线
- (void)setRedLine
{
    UIView *redLine = [[UIView alloc]init];
    [self.gtView addSubview:redLine];
    _redLine = redLine;
    redLine.backgroundColor = [UIColor redColor];
//    redLine.x = 0;
    redLine.y = self.gtView.height - 1;
    redLine.width = GTScreenWidth / 2;
    redLine.height = 1;
}

- (void)setNavigationBar
{
    // 设置导航栏左边的设置按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    [rightBtn setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    // 监听点击
    [rightBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    // 包装赋值
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 20);
//    self.navigationItem.rightBarButtonItems = @[];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

#pragma mark - 监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //tableView的偏移量
    CGFloat offset = self.tableView.contentOffset.y + 288;
    
    self.imageHeight.constant = 180 - offset;
    self.iconW.constant = self.iconH.constant = 50 - offset/116.5 * 20;
    if (self.imageHeight.constant < 64) {
        self.imageHeight.constant = 64;
        self.iconH.constant = self.iconW.constant = 30;
        
    }
 
}

#pragma mark - 按钮的点击

// 设置按钮
- (void)setting
{
    KVSettingViewController *setVc = [[KVSettingViewController alloc]init];
    setVc.title = @"设置";
    [self.navigationController pushViewController:setVc animated:YES];
}

// 购物车按钮
- (IBAction)gouwuche:(id)sender {
    NSLog(@"%s",__func__);
    
}
// 订单
- (IBAction)dingdan:(id)sender {
    NSLog(@"%s",__func__);
}
// 礼券
- (IBAction)liquan:(id)sender {
    NSLog(@"%s",__func__);
}

// 客服
- (IBAction)kefu:(id)sender {
    NSLog(@"%s",__func__);
}

// 选择喜欢的礼物
- (IBAction)gift_like:(id)sender {
    // 移动下划线
    _redLine.x = 0;
    
    // 在用户的服务器中获取数据
    NSArray *arr = @[@"喜欢的礼物1",@"喜欢的礼物2",@"喜欢的礼物3",@"喜欢的礼物4",@"喜欢的礼物5",@"喜欢的礼物1",@"喜欢的礼物2",@"喜欢的礼物3",@"喜欢的礼物4",@"喜欢的礼物5",@"喜欢的礼物1",@"喜欢的礼物2",@"喜欢的礼物3",@"喜欢的礼物4",@"喜欢的礼物5"];
    
    self.dataArr = arr;
    
    [self.tableView reloadData];
    
}

// 选择喜欢的攻略
- (IBAction)tactic_like:(id)sender {
    // 移动下划线
    _redLine.x = GTScreenWidth / 2;
    
    // 在用户的服务器中获取数据
    NSArray *arr = @[@"喜欢的攻略1",@"喜欢的攻略2",@"喜欢的攻略3",@"喜欢的攻略4",@"喜欢的攻略5",@"喜欢的攻略6",@"喜欢的攻略7",@"喜欢的攻略8",@"喜欢的攻略9",@"喜欢的攻略10",@"喜欢的攻略1",@"喜欢的攻略2",@"喜欢的攻略3",@"喜欢的攻略4",@"喜欢的攻略5",@"喜欢的攻略6",@"喜欢的攻略7",@"喜欢的攻略8",@"喜欢的攻略9",@"喜欢的攻略10"];
    
    self.dataArr = arr;
    
    [self.tableView reloadData];
}

// 跳转到登录
- (IBAction)login {
    
    KVLoginViewController *loginVc = [[KVLoginViewController alloc]init];
    loginVc.title = @"登录";
    KVNavigationController *nav = [[KVNavigationController alloc]initWithRootViewController:loginVc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
