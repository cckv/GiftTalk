//
//  KVCollectionViewCell.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVCollectionViewCell.h"
#import "KVHotSubGiftItem.h"
@interface KVCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;

@end

@implementation KVCollectionViewCell

- (void)setSubItem:(KVHotSubGiftItem *)subItem
{
    _subItem = subItem;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:subItem.cover_image_url] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    
    _nameLab.text = subItem.name;
    _nameLab.font = [UIFont setFontSize];
    
    _priceLab.text = [NSString stringWithFormat:@"￥:%@",subItem.price];;
    _priceLab.font = [UIFont setFontSize];
    
    _likeLab.text = [NSString stringWithFormat:@"❤️ %ld",subItem.favorites_count];
    _likeLab.font = [UIFont setFontSize];
    
}
- (void)awakeFromNib
{
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.layer.masksToBounds = YES;

}
@end
