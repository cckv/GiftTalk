//
//  KVTacticItem.h
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVTacticItem : NSObject

@property(nonatomic, assign) NSInteger status;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, strong) NSArray *channels;

@property(nonatomic, assign) NSInteger order;

@property(nonatomic, strong) NSString *name;

@end
