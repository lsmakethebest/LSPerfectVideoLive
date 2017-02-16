//
//  LSSettingTableController.m
//  至美直播
//
//  Created by 刘松 on 16/10/20.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSSettingTableController.h"

@interface LSSettingTableController ()

@end

@implementation LSSettingTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    [self addGroup1];
    [self addGroup2];
    [self addGroup3];
    [self addGroup4];
    
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, SCREEN_W, 80);
    

    
    UIButton *button=[[UIButton alloc]init];
    button.radius=5;
    button.backgroundColor=KCColor7;
    [button setTitle:@"退出" forState:UIControlStateNormal];
    button.frame=CGRectMake(20, 10, SCREEN_W-2*20, 50);
    
    [view addSubview:button];
    
    self.tableView.tableFooterView=view;
    
    
    [button addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
}
-(void)exit
{
    

    [UIApplication sharedApplication].keyWindow.rootViewController=[[UIStoryboard storyboardWithName:@"login" bundle:nil]instantiateInitialViewController];
    [[LSUserTool sharedUserTool]saveUserInfo:nil];
    return;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"action"]=@"exit";
    [HttpManager POSTWithURLString:@"user.php" parameters:params success:^(NSDictionary *response) {
        if ([ResponseModel mj_objectWithKeyValues:response].isSuccess) {
            [MBProgressHUD showSuccess:@"退出成功"];
            [UIApplication sharedApplication].keyWindow.rootViewController=[[UIStoryboard storyboardWithName:@"login" bundle:nil]instantiateInitialViewController];
        } else {
            [UIToast showMessage:response[@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];

}
-(void)addGroup1
{
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
    LSSettingItem *item1=[LSSettingArrowItem  settingItemWithTitle:@"账号与安全" icon:@"MorePush" desClass:nil];
    [group.items addObject:item1];
    [self.datas addObject:group];
    
    
}
-(void)addGroup2
{
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
    LSSettingItem *item1=[LSSettingArrowItem settingItemWithTitle:@"黑名单" icon:@"MoreUpdate"];
    LSSettingItem *item2=[LSSettingArrowItem settingItemWithTitle:@"短视频权限" icon:@"MoreHelp" desClass:nil];
    LSSettingItem *item3=[LSSettingArrowItem settingItemWithTitle:@"开播提醒" icon:@"MoreShare" desClass:[LSSettingTableController class]];
    LSSettingItem *item4=[LSSettingSwitchItem settingItemWithTitle:@"未关注人私信" icon:@"MoreShare" desClass:[LSSettingTableController class]];
    [group.items addObject:item1];
    [group.items addObject:item2];
    [group.items addObject:item3];
    [group.items addObject:item4];
    
    [self.datas addObject:group];
    
}
-(void)addGroup3
{
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
    LSSettingItem *item1=[LSSettingItem settingItemWithTitle:@"清理缓存" subTitle:@"1.1M" icon:nil];
    [group.items addObject:item1];
    [self.datas addObject:group];
}
-(void)addGroup4
{
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
    LSSettingItem *item1=[LSSettingArrowItem settingItemWithTitle:@"帮助和反馈" icon:@"MoreUpdate"];
    LSSettingItem *item2=[LSSettingArrowItem settingItemWithTitle:@"关于我们" icon:@"MoreHelp" desClass:nil];
    LSSettingItem *item3=[LSSettingArrowItem settingItemWithTitle:@"网络诊断" icon:@"MoreShare" desClass:[LSSettingTableController class]];
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
   
        return 20;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

@end
