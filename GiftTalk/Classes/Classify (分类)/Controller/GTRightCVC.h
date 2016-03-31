//
//  GTRightCVC.h
//  GiftTalk
//
//  Created by kv on 15/12/29.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTRightCVC;
@protocol GTRightVCVDelegate <NSObject>

@optional
- (void)giftRightCVC:(GTRightCVC*)rightCVC didClick:(NSIndexPath*)indexPath;
- (void)giftRightCVC:(GTRightCVC*)rightCVC from:(NSInteger)from to:(NSInteger)to;
@end

@interface GTRightCVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>
{
    NSInteger rowNum;
    NSInteger numberOfSections;
}
// 记录每一个 section 的高度
@property (nonatomic,strong) NSMutableArray *countArr;

@property (nonatomic,weak) id<GTRightVCVDelegate> delegate;
@property (nonatomic,strong) NSArray *kindMs;

@property (strong, nonatomic) UICollectionView *rightCollectionView;

@property (strong, nonatomic) NSMutableDictionary *moveDic;//纪录滚动到的位置

@end
