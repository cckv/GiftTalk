//
//  KVLoginViewController.m
//  GiftTalk
//
//  Created by kv on 16/1/14.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVLoginViewController.h"

#import "KVLoginView.h"
#import "KVOtherLoginView.h"

#import "KVRegisterViewController.h"

@interface KVLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *otherLoginView;

@property (nonatomic,weak) KVLoginView *loginView1;
@property (nonatomic,weak) KVOtherLoginView *otherView1;
@end

@implementation KVLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self setChildView];
}

- (void)setChildView
{
    KVLoginView *loginView2 = [KVLoginView loginViewForXib];
    [self.loginView addSubview:loginView2];
    _loginView1 = loginView2;
    
    KVOtherLoginView *otherView2 = [KVOtherLoginView loginViewForXib];
    [self.otherLoginView addSubview:otherView2];
    _otherView1 = otherView2;

}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // 布局子控件 frame
    _loginView1.frame = CGRectMake(0, 0, GTScreenWidth, self.loginView.height);
    
    _otherView1.frame = CGRectMake(0, 0, GTScreenWidth, self.otherLoginView.height * 0.7);
}
//- (void)layoutSublayersOfLayer:(CALayer *)layer
//{
//    [super layoutSublayersOfLayer:layer];
//    
//    // 布局子控件 frame
//    _loginView1.frame = CGRectMake(0, 0, GTScreenWidth, self.loginView.height);
//    
//    _otherView1.frame = CGRectMake(0, 0, GTScreenWidth, GTScreenHeight * 0.7);
//
//}
- (void)setNavigationBar
{
    UIButton *leftBar = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBar.frame = CGRectMake(0, 0, 50, 30);
    [leftBar setTitle:@"取消" forState:UIControlStateNormal];
    [leftBar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBar addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBar];

    UIButton *rightBar = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBar.frame = CGRectMake(0, 0, 50, 30);
    [rightBar setTitle:@"注册" forState:UIControlStateNormal];
    [rightBar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBar addTarget:self action:@selector(registerNum) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBar];
}

- (void)registerNum
{
    KVRegisterViewController *registerV = [[KVRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerV animated:YES];
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击屏幕退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
