//
//  KVSubGiftCollectionViewCell.m
//  GiftTalk
//
//  Created by kv on 16/1/14.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVSubGiftCollectionViewCell.h"

#import "GTGiftDetailItem.h"

@interface KVSubGiftCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iocnImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeLabel;


@end


@implementation KVSubGiftCollectionViewCell

- (void)setItem:(GTGiftDetailItem *)item
{
    _item = item;
    
    
    [_iocnImageView sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    
    _nameLabel.text = item.name;
    _nameLabel.font = [UIFont setFontSize];
    
    _priceLabel.text = [NSString stringWithFormat:@"￥:%@",item.price];
    _priceLabel.font = [UIFont setFontSize];

    _likeLabel.text = [NSString stringWithFormat:@"❤️ %ld",item.favorites_count];
    _likeLabel.font = [UIFont setFontSize];

}
- (void)awakeFromNib
{
    _iocnImageView.layer.cornerRadius = 5;
    _iocnImageView.layer.masksToBounds = YES;
    
}
@end
