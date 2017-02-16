//
//  City.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic,copy) NSString *city;

@property (nonatomic,copy) NSString *cityid;
@property (nonatomic,copy) NSString *provinceid;
@property(nonatomic,strong) NSArray *areas;


@end
