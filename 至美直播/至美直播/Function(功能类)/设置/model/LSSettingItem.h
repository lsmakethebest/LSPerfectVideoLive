//
//  LSSettingItem.h
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^LSSettingItemBlock)();
@interface LSSettingItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property(nonatomic,assign) Class desClass;
@property(nonatomic,assign) LSSettingItemBlock  option;
@property (nonatomic, copy) NSString *subTitle;
@property(nonatomic,strong) UIColor *subTitleColor;
@property (nonatomic,assign) UITableViewStyle tableStyle;


//option为不能跳转但是点击有一定效果实现
+(instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)icon;
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle icon:(NSString*)icon;



+(instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)icon desClass:(Class)desClass;
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle icon:(NSString*)icon desClass:(Class)desClass;


+(instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)icon desClass:(Class)desClass  subTitleColor:(UIColor*)subTitleColor;
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle icon:(NSString*)icon desClass:(Class)desClass subTitleColor:(UIColor*)subTitleColor ;
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle icon:(NSString*)icon desClass:(Class)desClass subTitleColor:(UIColor*)subTitleColor option:(LSSettingItemBlock)option;


@end
