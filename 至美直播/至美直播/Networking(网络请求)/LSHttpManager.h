//
//  LSHttpManager.h
//  至美直播
//
//  Created by 刘松 on 2017/1/16.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpManager.h"

@interface LSHttpManager :HttpManager



+(void)POST:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure;



@end
