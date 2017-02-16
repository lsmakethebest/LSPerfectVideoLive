//
//  KCSelectCityModel.h
//  driver
//
//  Created by 刘松 on 16/8/11.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "Area.h"
#import "City.h"
#import "Province.h"
#import <Foundation/Foundation.h>
@interface KCSelectCityModel : NSObject

@property(nonatomic, strong) Province *province;
@property(nonatomic, strong) City *city;
@property(nonatomic, strong) Area *area;

@end
