//
//  KVHotGiftItem.h
//  GiftTalk
//
//  Created by kv on 16/1/9.
//  Copyright © 2016年 kv. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KVHotSubGiftItem;
@interface KVHotGiftItem : NSObject
@property(nonatomic, strong) NSString *type;

@property(nonatomic, strong) KVHotSubGiftItem *data;

@end
