//
//  KVTitleButton.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVTitleButton.h"

@implementation KVTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted
{

}

@end
