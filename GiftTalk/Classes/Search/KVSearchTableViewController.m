//
//  KVSearchTableViewController.m
//  GiftTalk
//
//  Created by OpenCom on 16/4/29.
//  Copyright © 2016年 kv. All rights reserved.
//

#import "KVSearchTableViewController.h"

@interface KVSearchTableViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation KVSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNav];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textField resignFirstResponder];
}
// 设置导航栏
- (void)setNav
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.frame = CGRectMake(0, 0, GTScreenWidth - 100, 44);
    titleView.centerY = 44 * 0.5;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, titleView.height - 6 - 32, GTScreenWidth-70, 32)];
    
    //    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height - 8 - 32, 320, 32)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor blackColor];
    textField.placeholder = @"选择一份礼物,送给亲爱Ta吧";
//    textField.placeholderColor = UIColorFromRGB(0xcccccc);
    //    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.layer.cornerRadius = 6.0;
    textField.layer.masksToBounds = YES;
    
    //textField的搜索小视图
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
    container.backgroundColor = [UIColor redColor];
    UIImageView *searchIcon = [[UIImageView alloc] init];
//    searchIcon.size = CGSizeMake(15, 15);
    searchIcon.frame = CGRectMake(0, 0, 15, 15);
    searchIcon.x = 2;
    searchIcon.centerY = container.height * 0.5;
    searchIcon.image = [UIImage imageNamed:@"搜索_new.png"];
    [container addSubview:searchIcon];
    
    container.userInteractionEnabled = YES;
    [container addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldShouldReturn:)]];
    
    textField.rightView = container;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    //占位视图
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 32)];
    container.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    //光标颜色
    textField.tintColor = [UIColor greenColor];
    
    [titleView addSubview:textField];
    
    self.navigationItem.titleView = titleView;
    self.textField = textField;
    [self.textField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
