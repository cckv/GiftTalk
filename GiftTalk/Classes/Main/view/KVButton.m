//
//  KVButton.m
//  GiftTalk
//
//  Created by kv on 15/12/9.
//  Copyright © 2015年 kv. All rights reserved.
//

#import "KVButton.h"

@implementation KVButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:KVColor(128, 128, 128) forState:UIControlStateNormal];
        [self setTitleColor:KVColor(243, 53, 62) forState:UIControlStateSelected];
    }
    return self;
}
/*
- (void)setSelected:(BOOL)selected
{
//    UIColor *norColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
//    UIColor *selColor = [UIColor colorWithRed:243/255.0 green:53/255.0 blue:62/255.0 alpha:1];
//    UIColor *currColor = selected ? norColor : selColor;
//    self.titleLabel.textColor = currColor;
    NSLog(@"%s",__func__);
    [super setSelected:selected];
}
 */
// 取消高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width/4;
    CGFloat x = (contentRect.size.width - w)*0.5;
    
    return CGRectMake(x, 7, w, contentRect.size.height*0.45);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
//    NSLog(@"%@",NSStringFromCGRect(contentRect));
    CGFloat w = contentRect.size.width/2;
    CGFloat x = contentRect.size.width*0.5 - w*0.5;
    return CGRectMake(x, contentRect.size.height*0.5, w, contentRect.size.height*0.6);
}

@end
