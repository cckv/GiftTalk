//
//  KVSubTacticItem.h
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVSubTacticItem : NSObject
@property(nonatomic, assign) NSInteger status;

@property(nonatomic, assign) NSInteger group_id;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, assign) NSInteger items_count;

@property(nonatomic, assign) NSInteger order;

@property(nonatomic, strong) NSString *icon_url;

@property(nonatomic, strong) NSString *name;

@end
