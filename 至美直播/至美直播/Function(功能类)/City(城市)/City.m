//
//  City.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "City.h"
#import "Area.h"
@implementation City
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"areas":[Area class]};
}
@end
