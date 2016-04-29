//
//  GTRightCollectionCell.m
//  GiftTalk
//
//  Created by kv on 15/12/29.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTRightCollectionCell.h"
#import "GTSubCategoryItem.h"

@interface GTRightCollectionCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation GTRightCollectionCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSubItem:(GTSubCategoryItem *)subItem
{
    _subItem = subItem;
    
    _nameLab.text = subItem.name;
    _nameLab.font = [UIFont setFontSize];

    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:subItem.icon_url] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
}
@end
