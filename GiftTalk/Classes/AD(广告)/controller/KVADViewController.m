//
//  KVADViewController.m
//  GiftTalk
//
//  Created by kv on 16/1/11.
//  Copyright © 2016年 kv. All rights reserved.
//
// 定义code2参数值
static NSString * const code2 = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";

#import "KVADViewController.h"
#import "KVAdItem.h"
#import "KVTabBarViewController.h"

@interface KVADViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tishiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lunchImageView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (nonatomic,strong) KVAdItem *adItems;

/** 定时器*/
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation KVADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLaunchImage];
    
    // 提示
    self.tishiLabel.font = [UIFont setFontSize];
    
    // 获取广告的网络数据
    [self getData];
    
    // 添加定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    

}
#pragma mark - 定时器
// 每隔一秒调用
- (void)timeChange{
    
    // 定义广告时间
    static int time = 3;
    
    // 时间到了,跳转
    if (time == 0) {
        [self jump:nil];
    }
    
    // 时间减少
    time--;
    
    // 设置跳转按钮标题
    [_jumpBtn setTitle:[NSString stringWithFormat:@" 跳过(%d) ",time] forState:UIControlStateNormal];
    
}
// 点击按钮进入软件
- (IBAction)jump:(id)sender {
    // 跟换跟控制器
    KVTabBarViewController *tabBarVc = [[KVTabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    
    // 销毁定时器
    [_timer invalidate];
}
// 获取网路数据
- (void)getData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [responseObject[@"ad"] firstObject];
        
        _adItems = [KVAdItem mj_objectWithKeyValues:dict];
        
        // 3.计算图片显示高度
        CGFloat imageH = GTScreenWidth / _adItems.w * _adItems.h;
        
        // 4.显示广告界面
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GTScreenWidth, imageH)];
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:_adItems.w_picurl]];
        [self.adView addSubview:imageView];
        
        // 5.添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)tap
{
    NSURL *adUrl = [NSURL URLWithString:_adItems.ori_curl];
    if ([[UIApplication sharedApplication]canOpenURL:adUrl]) {
        
        [[UIApplication sharedApplication]openURL:adUrl];
    }
    
}


#pragma mark - 1.设置启动图片
- (void)setupLaunchImage
{
    // 判断下屏幕尺寸
    // 480:LaunchImage-700 568:LaunchImage-700-568
    // 667:LaunchImage-800-667h 736:LaunchImage-800-Portrait-736h
    if (iPhone4) { // iPhone4
        _lunchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    } else if (iPhone5) {
        _lunchImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone6) {
        _lunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone6p) {
        _lunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
    }
    
}
@end
