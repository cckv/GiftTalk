//
//  KVRgisterView.m
//  GiftTalk
//
//  Created by kv on 16/1/14.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVRgisterView.h"


@interface KVRgisterView() 
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@end


@implementation KVRgisterView

+ (instancetype)loginViewForXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib
{
    [self.phoneNumTextField becomeFirstResponder];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
