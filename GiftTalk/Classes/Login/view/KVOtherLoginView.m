//
//  KVOtherLoginView.m
//  GiftTalk
//
//  Created by kv on 16/1/14.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVOtherLoginView.h"

@interface KVOtherLoginView()



@end

@implementation KVOtherLoginView

+ (instancetype)loginViewForXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
//- (void)awakeFromNib
//{
//    self.autoresizingMask = UIViewAutoresizingNone;
//}

@end
