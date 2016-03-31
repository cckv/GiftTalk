//
//  GTLeftCell.h
//  GiftTalk
//
//  Created by kv on 15/12/29.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTLeftCell : UITableViewCell

@property (nonatomic,copy) NSString *title;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
