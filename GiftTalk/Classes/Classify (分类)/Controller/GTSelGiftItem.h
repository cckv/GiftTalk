//
//  GTSelGiftItem.h
//  GiftTalk
//
//  Created by kv on 16/1/2.
//  Copyright © 2016年 luoping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTSelGiftItem : NSObject

@property(nonatomic, assign) NSInteger favorites_count;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, strong) NSString *price;

@property(nonatomic, assign) BOOL liked;

@property(nonatomic, strong) NSString *cover_image_url;

@property(nonatomic, strong) NSString *Description;

@property(nonatomic, strong) NSString *name;


@end
