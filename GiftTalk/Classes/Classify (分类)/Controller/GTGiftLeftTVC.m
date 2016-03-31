//
//  GTGiftLeftTVC.m
//  GiftTalk
//
//  Created by kv on 15/12/28.
//  Copyright © 2015年 luoping. All rights reserved.
//

#import "GTGiftLeftTVC.h"
#import "GTLeftCell.h"

@interface GTGiftLeftTVC ()


@end

@implementation GTGiftLeftTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
#warning why--为什么注册的 cell 还是有重用的问题
    // 注册 cell
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GTLeftCell class]) bundle:nil] forCellReuseIdentifier:@"leftCell"];
}
- (void)setKindMs:(NSArray *)kindMs
{
    _kindMs = kindMs;
    
    [self.tableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.kindMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建 cell
    GTLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([GTLeftCell class]) owner:nil options:nil].lastObject;
    }
    // 取出模型数组
    GTCategoryItem *item = self.kindMs[indexPath.row];
    cell.title = item.name;
//    cell.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];
    
    
    cell.titleLab.font = [UIFont setFontSize];
//    cell.textLabel.font = [UIFont systemFontOfSize:8];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 代理
    if ([self.delegate respondsToSelector:@selector(giftLeftTVC:didClickCellIndex:)])
    {
        [self.delegate giftLeftTVC:self didClickCellIndex:indexPath.row];
    }
    // 选中
    self.selectCell.titleLab.textColor = [UIColor blackColor];
    GTLeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.titleLab.textColor = [UIColor redColor];
    self.selectCell = cell;

}
@end
