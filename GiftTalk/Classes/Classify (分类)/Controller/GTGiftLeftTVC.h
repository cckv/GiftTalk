//
//  GTGiftLeftTVC.h
//  GiftTalk
//
//  Created by kv on 15/12/28.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTGiftLeftTVC,GTLeftCell;
@protocol GTGiftLeftTVCDelegate <NSObject>
@optional
- (void)giftLeftTVC:(GTGiftLeftTVC*)leftTVC didClickCellIndex:(NSInteger)index;
@end

@interface GTGiftLeftTVC : UITableViewController

@property (nonatomic,strong) GTLeftCell *selectCell;

// 代理属性
@property (nonatomic,weak) id<GTGiftLeftTVCDelegate> delegate;
/** 数据模型 */
@property (nonatomic,strong) NSArray *kindMs;
@end
