//
//  KVTabBar.h
//  GiftTalk
//
//  Created by kv on 15/12/9.
//  Copyright © 2015年 kv. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KVTabBar;
@protocol KVTabBarDelegate <NSObject>

- (void)tabBar:(KVTabBar*)tabBar didClickBtnFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface KVTabBar : UIView
@property (nonatomic,weak) id<KVTabBarDelegate> delegate;
@property (nonatomic,strong) NSArray *itemArr;
@end
