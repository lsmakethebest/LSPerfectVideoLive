

//
//  LSHttpManager.m
//  至美直播
//
//  Created by 刘松 on 2017/1/16.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSHttpManager.h"



@implementation LSHttpManager




+(void)POST:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure
{
    
    NSString *url=StringFormat(BASE_URL, URLString);
    NSLog(@"请求地址:%@",url);
    NSLog(@"请求参数:%@",parameters);
    [self POSTWithURLString:url parameters:parameters success:^(NSDictionary *response) {
        if (success) {
            NSLog(@"请求结果:%@",response);
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"请求失败:%@",error.localizedDescription);
            failure(error);
        }
    }];
}




@end
