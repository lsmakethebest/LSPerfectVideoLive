



//
//  LSSettingTableController.m
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSMineTableController.h"
#import "LSPushController.h"
#import "LSSettingTableController.h"

@interface LSMineTableController ()

@end

@implementation LSMineTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup1];
    [self addGroup2];

    
}
-(void)addGroup1
{
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
//    group.headerTitle=@"头";
//    group.footerTitle=@"尾标题";
    LSSettingItem *item1=[LSSettingArrowItem  settingItemWithTitle:@"映票贡献榜" icon:@"MorePush" desClass:[LSPushController class]];
    LSSettingItem *item2=[LSSettingArrowItem settingItemWithTitle:@"我的一天" icon:@"handShake"];
    LSSettingItem *item3=[LSSettingArrowItem settingItemWithTitle:@"收益" subTitle:@"35映票" icon:nil desClass:[LSMineTableController class] subTitleColor:[UIColor redColor]];
    LSSettingItem *item4=[LSSettingArrowItem settingItemWithTitle:@"账户" subTitle:@"0砖石" icon:nil desClass:[LSMineTableController class] subTitleColor:[UIColor redColor]];
    [group.items addObject:item1];
    [group.items addObject:item2];
    [group.items addObject:item3];
    [group.items addObject:item4];
    [self.datas addObject:group];
    
    
}
-(void)addGroup2
{
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
//    group.headerTitle=@"头标题";
//    group.footerTitle=@"尾标题";
    LSSettingItem *item1=[LSSettingArrowItem settingItemWithTitle:@"等级" icon:@"MoreUpdate"];
    item1.option=^(){
    
    
    };
    LSSettingItem *item2=[LSSettingArrowItem settingItemWithTitle:@"实名认证" icon:@"MoreHelp" desClass:nil];
    LSSettingItem *item3=[LSSettingArrowItem settingItemWithTitle:@"设置" icon:@"MoreShare" desClass:[LSSettingTableController class]];
    item3.tableStyle=UITableViewStyleGrouped;
    [group.items addObject:item1];
    [group.items addObject:item2];
    [group.items addObject:item3];

    
    [self.datas addObject:group];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGFLOAT_MIN;
    }else{
        return 20;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
        return CGFLOAT_MIN;
}
@end
