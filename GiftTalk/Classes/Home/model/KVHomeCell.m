//
//  KVHomeCell.m
//  GiftTalk
//
//  Created by kv on 16/1/10.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVHomeCell.h"
#import "KVHomeCellItem.h"
@interface KVHomeCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIView *contentView1;

@end

@implementation KVHomeCell

- (void)awakeFromNib {
    
    _iconImageV.layer.cornerRadius = 5;
    _iconImageV.layer.masksToBounds = YES;

}
+ (instancetype)createCell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setItem:(KVHomeCellItem *)item
{
    _item = item;
    
    _contentView1.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url]];
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    
    self.likeLab.text = [NSString stringWithFormat:@"%ld",item.likes_count];
    
    self.nameLab.text = item.title;
}
@end
