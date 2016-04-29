//
//  KVSelCollectionViewCell.m
//  GiftTalk
//
//  Created by kv on 16/1/14.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVSelCollectionViewCell.h"
#import "GTSelGiftItem.h"

@interface KVSelCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLale;

@property (weak, nonatomic) IBOutlet UILabel *princeLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end

@implementation KVSelCollectionViewCell


- (void)setItem:(GTSelGiftItem *)item
{
    _item = item;
    
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    
    _nameLale.text = item.name;
    _nameLale.font = [UIFont setFontSize];
    
    _princeLabel.text = [NSString stringWithFormat:@"￥:%@",item.price];
    _princeLabel.font = [UIFont setFontSize];
    
    _likeLabel.text = [NSString stringWithFormat:@"❤️ %ld",item.favorites_count];
    _likeLabel.font = [UIFont setFontSize];
    
}
- (void)awakeFromNib
{
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.layer.masksToBounds = YES;
    
}

@end
