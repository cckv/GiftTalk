//
//  KVTacticDetailCell.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVTacticDetailCell.h"
#import "KVTacticDetailItem.h"
@interface KVTacticDetailCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;
@property (weak, nonatomic) IBOutlet UIView *contentView1;

@end

@implementation KVTacticDetailCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setItem:(KVTacticDetailItem *)item
{
    _item = item;
    _contentView1.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    
    _nameLab.text = item.title;
    
    _likeLab.text = [NSString stringWithFormat:@"%ld",item.likes_count];
    
}
@end
