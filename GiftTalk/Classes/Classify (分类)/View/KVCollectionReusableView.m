//
//  KVCollectionReusableView.m
//  GiftTalk
//
//  Created by kv on 16/3/2.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVCollectionReusableView.h"

@interface KVCollectionReusableView()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@end

@implementation KVCollectionReusableView

- (void)setName:(NSString *)name
{
    _name = name;
    
    self.nameLabel.text = name;
}

@end
