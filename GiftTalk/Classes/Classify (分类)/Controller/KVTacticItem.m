//
//  KVTacticItem.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVTacticItem.h"
#import "KVSubTacticItem.h"
@implementation KVTacticItem
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"channels" : [KVSubTacticItem class]};
}
@end
