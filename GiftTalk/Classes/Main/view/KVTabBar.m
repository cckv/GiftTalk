//
//  KVTabBar.m
//  GiftTalk
//
//  Created by kv on 15/12/9.
//  Copyright © 2015年 kv. All rights reserved.
//

#import "KVTabBar.h"
#import "KVButton.h"


@interface KVTabBar()
@property (nonatomic,weak) KVButton *selectBtn;
@end
@implementation KVTabBar

- (void)setItemArr:(NSArray *)itemArr
{
    
    NSInteger count = itemArr.count;

    for (int i = 0; i < count; i ++) {
        UITabBarItem *item = itemArr[i];
        KVButton *btn = [KVButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
//       设置图片
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
//        NSLog(@"%@",item.title);
        // 设置按钮文字及属性
        [btn setTitle:item.title forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        btn.font = [UIFont systemFontOfSize:11];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        
        if(i == 0)
        {
            [self btnClick:btn];
        }
    }
}
- (void)btnClick:(KVButton*)btn
{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickBtnFrom:to:)]) {
        [self.delegate tabBar:self didClickBtnFrom:self.selectBtn.tag to:btn.tag];
    }
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat y = 0;
    CGFloat w = self.bounds.size.width/count;
    CGFloat h = self.bounds.size.height;
    for (int i = 0; i < count; i ++) {
        KVButton *btn = self.subviews[i];
        
        btn.frame = CGRectMake(w * i, y, w, h);
    }
}
@end
