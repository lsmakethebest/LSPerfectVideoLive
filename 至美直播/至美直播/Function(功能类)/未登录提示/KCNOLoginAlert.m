


//
//  KCNOLoginAlert.m
//  driver
//
//  Created by 刘松 on 16/10/11.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCNOLoginAlert.h"
//#import "KCLoginViewController.h"

@implementation KCNOLoginAlert


+(BOOL)isLoginAndAlertWithNavigatinController:(UINavigationController *)nav
{
    if ([LSUserTool sharedUserTool].userModel==nil) {
        [AlertTool showWithViewController:nav title:@"未登录" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"去登录" confirm:^{
//            [nav pushViewController:[[KCLoginViewController alloc]init] animated:YES];
            
        } cancle:nil];
        return NO;
    }
    return  YES;
}

@end
