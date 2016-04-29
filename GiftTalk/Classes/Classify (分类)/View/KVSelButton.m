//
//  KVSelButton.m
//  GiftTalk
//
//  Created by kv on 16/1/14.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVSelButton.h"

@implementation KVSelButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.imageView.x = 10;
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
    
    
}


@end
