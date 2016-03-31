//
//  GTHeadDataItem.h
//  GiftTalk
//
//  Created by kv on 16/1/1.
//  Copyright © 2016年 luoping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTHeadDataItem : NSObject
@property(nonatomic, assign) NSInteger status;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, strong) NSArray *channels;

@property(nonatomic, strong) NSString *key;

@property(nonatomic, strong) NSString *name;

@property(nonatomic, assign) NSInteger order;

@end
