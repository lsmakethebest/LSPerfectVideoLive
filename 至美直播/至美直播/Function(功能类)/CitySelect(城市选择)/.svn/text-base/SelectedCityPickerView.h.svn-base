//
//  SelectedCityPickerView.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Province.h"
#import "City.h"
#import "Area.h"

typedef void (^CityClickClosure)(Province *province,City *city,Area *area);


IB_DESIGNABLE
@interface SelectedCityPickerView : UIView
+ (void)showCityPickerViewWithClickClosure:(CityClickClosure)clickClosure;
@property (nonatomic,copy) CityClickClosure clickClosure;

@end
