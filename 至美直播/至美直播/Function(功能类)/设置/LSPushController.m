//
//  LSPushController.m
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSPushController.h"

@interface LSPushController ()

@end

@implementation LSPushController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup1];
    
    
    
}

-(void)addGroup1
{
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
    group.headerTitle=@"头";
    group.footerTitle=@"尾标题";
    LSSettingItem *item1=[LSSettingArrowItem settingItemWithTitle:@"开奖号码推送" icon:nil desClass:nil];
    LSSettingItem *item2=[LSSettingArrowItem settingItemWithTitle:@"中奖动画" icon:nil];
    LSSettingItem *item3=[LSSettingArrowItem settingItemWithTitle:@"比分直播提醒" icon:nil];
    LSSettingItem *item4=[LSSettingArrowItem settingItemWithTitle:@"购彩定时提醒" icon:nil desClass:[LSPushController class]];
    [group.items addObject:item1];
    [group.items addObject:item2];
    [group.items addObject:item3];
    [group.items addObject:item4];
    [self.datas addObject:group];
    
    
}


@end
