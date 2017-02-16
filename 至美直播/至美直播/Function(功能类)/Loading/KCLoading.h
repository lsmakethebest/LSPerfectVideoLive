//
//  KCLoading.h
//  driver
//
//  Created by 刘松 on 16/7/7.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCLoading : UIView

+(void)show;
+(void)hide;

+(void)showToView:(UIView*)view;
+(void)hideForView:(UIView*)view;

@end
