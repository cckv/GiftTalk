//
//  GTFilterItem.h
//  GiftTalk
//
//  Created by kv on 16/1/1.
//  Copyright © 2016年 luoping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTFilterItem : NSObject
@property(nonatomic, assign) NSInteger status;

@property(nonatomic, assign) NSInteger group_id;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, assign) NSInteger items_count;

@property(nonatomic, assign) NSInteger order;

@property(nonatomic, assign) NSInteger key;

@property(nonatomic, strong) NSString *name;
@end
