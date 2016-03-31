//
//  GTHeadDataItem.m
//  GiftTalk
//
//  Created by kv on 16/1/1.
//  Copyright © 2016年 luoping. All rights reserved.
//

#import "GTHeadDataItem.h"
#import "GTFilterItem.h"
@implementation GTHeadDataItem
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"channels" : [GTFilterItem class]};
}
@end
