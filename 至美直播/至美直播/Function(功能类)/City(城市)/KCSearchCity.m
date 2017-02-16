

//
//  KCSearchCity.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/10.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "Area.h"
#import "City.h"
#import "KCSearchCity.h"
#import "Province.h"
@interface KCSearchCity ()
@property(nonatomic, strong) NSArray *allCitys;
@end
@implementation KCSearchCity
singalton_m(SearchCity);

- (NSArray *)allCitys {
  if (!_allCitys) {
    NSDictionary *dict = [NSDictionary
        dictionaryWithContentsOfURL:[[NSBundle mainBundle]
                                        URLForResource:@"citys.plist"
                                         withExtension:nil]];
    _allCitys = [Province mj_objectArrayWithKeyValuesArray:dict[@"citys"]];
  }
  return _allCitys;
}

- (Area *)searchAreaWithAreaName:(NSString *)areaName {
  for (Province *province in self.allCitys) {
    for (City *city in province.cityArrayList) {
      for (Area *area in city.areas) {
        if ([area.area rangeOfString:areaName].length > 0) {
          return area;
        }
      }
    }
  }
  return nil;
}
@end
