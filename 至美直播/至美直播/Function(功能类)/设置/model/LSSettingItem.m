


//
//  LSSettingItem.m
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSSettingItem.h"

@implementation LSSettingItem


// title  icon
+(instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)icon
{
    return [self settingItemWithTitle:title subTitle:nil icon:icon desClass:nil subTitleColor:nil];
}
// title  subTitle icon
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle icon:(NSString*)icon
{
    return [self settingItemWithTitle:title subTitle:subTitle icon:icon desClass:nil subTitleColor:nil];
}


// title  icon desClass
+(instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)icon desClass:(Class)desClass
{
    return [self settingItemWithTitle:title subTitle:nil icon:icon desClass:desClass subTitleColor:nil];
}
// title  subTitle icon desClass
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle icon:(NSString*)icon desClass:(Class)desClass
{
    return [self settingItemWithTitle:title subTitle:subTitle icon:icon desClass:desClass subTitleColor:nil];
}


// title icon desClass subTitleColor
+(instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)icon desClass:(Class)desClass  subTitleColor:(UIColor*)subTitleColor
{
    return [self settingItemWithTitle:title subTitle:nil icon:icon desClass:desClass subTitleColor:subTitleColor];
}

// title subTitle icon desClass subTitleColor

+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle icon:(NSString*)icon desClass:(Class)desClass subTitleColor:(UIColor*)subTitleColor ;
{
     return [self settingItemWithTitle:title subTitle:subTitle icon:icon desClass:desClass subTitleColor:subTitleColor option:nil];
}
// title subTitle icon desClass subTitleColor

+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle icon:(NSString*)icon desClass:(Class)desClass subTitleColor:(UIColor*)subTitleColor option:(LSSettingItemBlock)option;
{
    LSSettingItem *item=[[self alloc]init];
    item.title=title;
    item.icon=icon;
    item.subTitle=subTitle;
    item.desClass=desClass;
    item.subTitleColor=subTitleColor;
    item.option=option;
    return item;
}

@end
