//
//  KVHeaderItem.h
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVHeaderItem : NSObject
@property(nonatomic, assign) NSInteger status;

@property(nonatomic, strong) NSString *channel;

@property(nonatomic, strong) NSDictionary *target;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, strong) NSString *image_url;

@property(nonatomic, assign) NSInteger order;

@property(nonatomic, strong) NSString *target_url;

@property(nonatomic, strong) NSString *type;

@property(nonatomic, assign) NSInteger target_id;

@end
