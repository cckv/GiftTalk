//
//  KVSearchTableViewController.m
//  GiftTalk
//
//  Created by OpenCom on 16/4/29.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVSearchTableViewController.h"

#import "GTSelectGiftVC.h"

@interface KVSearchTableViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSArray *hot_Arr;
@property (nonatomic, strong) UIView *headView;
@end

@implementation KVSearchTableViewController
- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        label.text = @"大家都在搜:";
        [_headView addSubview:label];
        label.frame = CGRectMake(10, 5, 200, 30);
        _headView.frame = CGRectMake(0, 0, GTScreenWidth, 160);
        _headView.backgroundColor = [UIColor colorWithRed:50 green:50 blue:50 alpha:1];
        
        UIView *contentView = [[UIView alloc]init];
        [_headView addSubview:contentView];
        contentView.frame = CGRectMake(0, 30, GTScreenWidth, 120);
        contentView.backgroundColor = [UIColor blueColor];
        
        for (int i = 0; i < self.hot_Arr.count; i++) {
        
            int row = i % 4;
            int col = i / 4;
            int margin = 10;
            CGFloat w = (GTScreenWidth - 50)/4;
            CGFloat h = 30;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor redColor];
            [btn setTitle:self.hot_Arr[i] forState:UIControlStateNormal];
            [contentView addSubview:btn];
            btn.frame = CGRectMake(margin+ row * (w+margin), col *(h + margin), w, h);
        }
        
    }
    return _headView;
}
- (NSArray *)hot_Arr
{
    if (_hot_Arr == nil) {
        _hot_Arr = [NSArray array];
    }
    return _hot_Arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNav];
    
    self.tableView.bounces = NO;
    
//    self.tableView.contentSize = CGSizeMake(0, GTScreenHeight + 300);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 220, 0);
    
}

- (void)setHeadView
{
    self.tableView.tableHeaderView = self.headView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.textField becomeFirstResponder];
    // 获取数据
    [self getData];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.textField resignFirstResponder];
}
- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {

    }
    return self;
}

- (void)getData
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = nil;
    
    [manager GET:@"http://api.liwushuo.com/v2/search/hot_words?" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        
        self.textField.placeholder = dict[@"placeholder"];
        
        self.hot_Arr = dict[@"hot_words"];
        
        [self setHeadView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

// 设置导航栏
- (void)setNav
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.frame = CGRectMake(0, 0, GTScreenWidth - 100, 44);
    titleView.centerY = 44 * 0.5;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, titleView.height - 6 - 32, GTScreenWidth-70, 32)];
    
    //    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height - 8 - 32, 320, 32)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor blackColor];
    textField.placeholder = @"选择一份礼物,送给亲爱Ta吧";
//    textField.placeholderColor = UIColorFromRGB(0xcccccc);
    //    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.layer.cornerRadius = 6.0;
    textField.layer.masksToBounds = YES;
    
    //textField的搜索小视图
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
    container.backgroundColor = [UIColor redColor];
    UIImageView *searchIcon = [[UIImageView alloc] init];
//    searchIcon.size = CGSizeMake(15, 15);
    searchIcon.frame = CGRectMake(0, 0, 15, 15);
    searchIcon.x = 2;
    searchIcon.centerY = container.height * 0.5;
    searchIcon.image = [UIImage imageNamed:@"搜索_new.png"];
    [container addSubview:searchIcon];
    
    container.userInteractionEnabled = YES;
    [container addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldShouldReturn:)]];
    
    textField.rightView = container;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    //占位视图
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 32)];
    container.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    //光标颜色
    textField.tintColor = [UIColor greenColor];
    
    [titleView addSubview:textField];
    
    self.navigationItem.titleView = titleView;
    self.textField = textField;
    [self.textField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"选礼神器";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTSelectGiftVC *selectVc = [[GTSelectGiftVC alloc]init];
    [self.navigationController pushViewController:selectVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self.textField endEditing:YES];
//}
@end
