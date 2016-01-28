//
//  UIFont+KVFont.m
//  GiftTalk
//
//  Created by kv on 16/1/14.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "UIFont+KVFont.h"

@implementation UIFont (KVFont)
+ (UIFont*)setFontSize
{
    if (iPhone4) {
        return [UIFont systemFontOfSize:9];
    }else if (iPhone5)
    {
        return [UIFont systemFontOfSize:12];
    }else if (iPhone6)
    {
        return [UIFont systemFontOfSize:14];
    }else if (iPhone6p)
    {
        return [UIFont systemFontOfSize:16];
    }
    return nil;
}
@end
