//
//  GTCategoryItem.m
//  GiftTalk
//
//  Created by kv on 15/12/27.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTCategoryItem.h"
#import "MJExtension/MJExtension.h"
#import "GTSubCategoryItem.h"

@implementation GTCategoryItem
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"subcategories" : [GTSubCategoryItem class]};
}

@end
