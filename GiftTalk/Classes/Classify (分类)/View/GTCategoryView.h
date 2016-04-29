//
//  GTCategoryView.h
//  GiftTalk
//
//  Created by kv on 16/1/2.
//  Copyright © 2016年 luoping. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTCategoryView;
// 点击按钮后通知控制器做事情
@protocol GTCategoryViewDelegate <NSObject>
@optional
- (void)categoryView:(GTCategoryView*)categoryView didClick:(UIButton*)btn;
@end

#import "GTHeadDataItem.h"
@interface GTCategoryView : UIView

@property (nonatomic,weak) id<GTCategoryViewDelegate>delegate;
// 数据模型
@property (nonatomic,strong) GTHeadDataItem *item;

@end
