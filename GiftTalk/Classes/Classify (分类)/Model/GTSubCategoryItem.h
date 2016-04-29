//
//  GTSubCategoryItem.h
//  GiftTalk
//
//  Created by kv on 15/12/27.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTSubCategoryItem : NSObject
@property(nonatomic, assign) NSInteger status;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, assign) NSInteger items_count;

@property(nonatomic, assign) NSInteger order;

@property(nonatomic, strong) NSString *icon_url;

@property(nonatomic, assign) NSInteger parent_id;

@property(nonatomic, strong) NSString *name;
@end
