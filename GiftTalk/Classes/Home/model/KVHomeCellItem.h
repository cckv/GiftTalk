//
//  KVHomeCellItem.h
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVHomeCellItem : NSObject
@property(nonatomic, strong) NSString *cover_image_url;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, assign) NSInteger published_at;

@property(nonatomic, strong) NSString *Template;

@property(nonatomic, assign) NSInteger editor_id;

@property(nonatomic, assign) NSInteger created_at;

@property(nonatomic, strong) NSString *content_url;

@property(nonatomic, strong) NSArray *labels;

@property(nonatomic, strong) NSString *url;

@property(nonatomic, strong) NSString *type;

@property(nonatomic, strong) NSString *share_msg;

@property(nonatomic, strong) NSString *title;

@property(nonatomic, assign) NSInteger updated_at;

@property(nonatomic, strong) NSString *short_title;

@property(nonatomic, assign) BOOL liked;

@property(nonatomic, assign) NSInteger likes_count;

@property(nonatomic, assign) NSInteger status;

@end
