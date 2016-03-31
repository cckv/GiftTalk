//
//  KVRegisterViewController.m
//  GiftTalk
//
//  Created by kv on 16/1/14.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVRegisterViewController.h"

#import "KVRgisterView.h"

@interface KVRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *registerView;

@property (nonatomic,weak) KVRgisterView *registerV;
@end

@implementation KVRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KVRgisterView *registerView = [KVRgisterView loginViewForXib];
    _registerV = registerView;
    [self.registerView addSubview:registerView];
    
    // 设置 phoneNumTextField 为键盘的第一响应者
//    [self.registerV.phoneNumTextField becomeFirstResponder];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置 phoneNumTextField 为键盘的第一响应者
//    [self.registerV.phoneNumTextField becomeFirstResponder];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _registerV.frame = CGRectMake(0, 0, GTScreenWidth, self.registerView.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
