//
//  KCSearchCity.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/10.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Province.h"
#import "Area.h"
@interface KCSearchCity : NSObject
singalton_h(SearchCity);
-(Area*)searchAreaWithAreaName:(NSString*)areaName;
@end
