
//
//  GTCategoryView.m
//  GiftTalk
//
//  Created by kv on 16/1/2.
//  Copyright © 2016年 luoping. All rights reserved.
//

#import "GTCategoryView.h"
#import "GTFilterItem.h"
@implementation GTCategoryView

- (void)setItem:(GTHeadDataItem *)item
{
    _item = item;
    for(UIButton *subView in self.subviews)
    {
        if([subView.class isSubclassOfClass:[UIButton class]])
        {
            [subView removeFromSuperview];
        }
    }
    for (int i = 0; i < self.item.channels.count + 1; i++) {
        UIButton *btn = [[UIButton alloc]init];
        if (i != 0) {
            GTFilterItem *subItem = self.item.channels[i-1];
            [btn setTitle:subItem.name forState:UIControlStateNormal];
        }else
        {
            [btn setTitle:@"全部" forState:UIControlStateNormal];
        }
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    }
    
}
- (void)btnClick:(UIButton*)btn
{
    if ([self.delegate respondsToSelector:@selector(categoryView:didClick:)]) {
        [self.delegate categoryView:self didClick:btn];
    }
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"selSubCateNoti" object:btn];
}


- (void)layoutSubviews
{
    int count = (int)self.subviews.count;
//    NSLog(@"%d",count);
    CGFloat margin = 10;
    CGFloat btnW = (self.width - (4*margin))/3;
    CGFloat btnH = 30;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        int row = i / 3;
        int low = i % 3;
        btnX = margin + low * (btnW + margin);
        btnY = margin + row * (btnH + margin);
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}
@end
