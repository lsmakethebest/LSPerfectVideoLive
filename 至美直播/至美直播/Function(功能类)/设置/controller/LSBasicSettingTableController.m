
//
//  LSBasicTableController.m
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSBasicSettingTableController.h"
#import "LSSettingGroup.h"
#import "LSSettingCell.h"

@interface LSBasicSettingTableController ()



@end

@implementation LSBasicSettingTableController

-(NSMutableArray *)datas
{
    if (_datas==nil) {
        _datas=[NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

}
-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return self.datas.count;
}
-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LSSettingGroup *group=self.datas[section];
    return group.items.count;
}



-(UITableViewCell*)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    LSSettingCell *cell=[LSSettingCell settingCellWithTableView:tableView];
    LSSettingGroup *group=self.datas[indexPath.section];
    LSSettingItem *item=group.items[indexPath.row];
    cell.item=item;
    return cell;
}

-(void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSSettingGroup *group=self.datas[indexPath.section];
    LSSettingItem *item=group.items[indexPath.row];
    if (item.option) {
        item.option();
    }
     else if (item.desClass) {
         id vc;
         if ([item.desClass isSubclassOfClass:[UITableViewController class]]) {
             vc=[[item.desClass alloc]initWithStyle:item.tableStyle];
         }else{
             vc=[[item.desClass alloc]init];
         }
        [vc setTitle:item.title];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(NSString *)tableView:(nonnull UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    LSSettingGroup *group=self.datas[section];
    return group.footerTitle;
}
-(NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    LSSettingGroup *group=self.datas[section];
    return group.headerTitle;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
     view.tintColor = [UIColor clearColor];
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer.textLabel setTextColor:[UIColor redColor]];
    
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
