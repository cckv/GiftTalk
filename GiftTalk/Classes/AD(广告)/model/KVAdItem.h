//
//  KVAdItem.h
//  GiftTalk
//
//  Created by kv on 16/1/11.
//  Copyright © 2016年 kv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVAdItem : NSObject
/** 广告图片*/
@property (nonatomic, strong) NSString *w_picurl;

// 点击广告图片,进入界面
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@end
