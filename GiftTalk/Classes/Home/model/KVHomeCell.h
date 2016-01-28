//
//  KVHomeCell.h
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KVHomeCellItem;
@interface KVHomeCell : UITableViewCell
@property (nonatomic,strong) KVHomeCellItem *item;

+ (instancetype)createCell;

@end
