//
//  KCSelectCityView.h
//  driver
//
//  Created by 刘松 on 16/8/1.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Province.h"
#import "City.h"
#import "Area.h"

typedef void(^KCSelectCityViewBlock)(NSString *code,NSString *name);
typedef void(^KCSelectCityViewBackBlock)();

@interface KCSelectCityView : UIView

+(instancetype)showWithFrame:(CGRect)frame view:(UIView*)view block:(KCSelectCityViewBlock)block backBlock:(KCSelectCityViewBackBlock)backBlock;

@end
