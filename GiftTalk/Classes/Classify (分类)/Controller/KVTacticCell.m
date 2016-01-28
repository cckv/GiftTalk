//
//  KVTacticCell.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVTacticCell.h"
#import "KVSubTacticItem.h"
@interface KVTacticCell() 
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation KVTacticCell
- (void)setSubItem:(KVSubTacticItem *)subItem
{
    _subItem = subItem;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:subItem.icon_url] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    
    _nameLab.text = subItem.name;
    _nameLab.font = [UIFont setFontSize];
}
- (void)awakeFromNib {
    // Initialization code
}

@end
