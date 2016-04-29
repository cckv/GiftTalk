//
//  KVHotSubGiftItem.h
//  GiftTalk
//
//  Created by kv on 16/1/9.
//  Copyright © 2016年 kv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVHotSubGiftItem : NSObject

@property(nonatomic, strong) NSString *Description;

@property(nonatomic, assign) NSInteger editor_id;

@property(nonatomic, strong) NSString *url;

@property(nonatomic, strong) NSString *purchase_url;

@property(nonatomic, strong) NSArray *image_urls;

@property(nonatomic, assign) BOOL is_favorite;

@property(nonatomic, assign) NSInteger updated_at;

@property(nonatomic, assign) NSInteger purchase_type;

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSArray *post_ids;

@property(nonatomic, assign) NSInteger purchase_status;

@property(nonatomic, assign) NSInteger favorites_count;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, strong) NSString *purchase_id;

@property(nonatomic, assign) NSInteger subcategory_id;

@property(nonatomic, assign) NSInteger created_at;

@property(nonatomic, strong) NSString *price;

@property(nonatomic, assign) NSInteger category_id;

@property(nonatomic, strong) NSString *cover_image_url;
@end
