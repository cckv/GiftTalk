//
//  KVAnimationView.m
//  GiftTalk
//
//  Created by kv on 16/1/28.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVAnimationView.h"

@implementation KVAnimationView

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.x < 0) {
        self.x = 0;
        return;
    }
    UITouch *touch = [touches anyObject];
    //1.获取当前手指所在点。
    CGPoint curP = [touch locationInView:self];
    //2.获取上一个手指所在点
    CGPoint preP =  [touch previousLocationInView:self];
    //3.计算偏移量（当前手指所在点 - 上一个手指所在点）
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;

    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    
}
//当手指在当前View上移开时调用。
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    //1.获取当前手指所在点。
    CGPoint curP = [touch locationInView:self];
    CGPoint point = [self convertPoint:CGPointMake(30, 30) fromView:self.superview];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width/2;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat pointY = -point.y;
    CGFloat curY = pointY + curP.y;
    if (point.x > -108) {
        if (pointY < 0) {
            pointY = 0;
        }
        if (curY > h - 49) {
            curY = h - 49;
        }
        self.frame = CGRectMake(0, curY, self.bounds.size.width, self.bounds.size.height);
    }else
    {
        if (pointY < 0) {
            pointY = 0;
        }
        if (curY > h - 49) {
            curY = h - 49;
        }
        self.frame = CGRectMake(w*2-self.bounds.size.width, curY, self.bounds.size.width, self.bounds.size.height);
    }
}

@end
