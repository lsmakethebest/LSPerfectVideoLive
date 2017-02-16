


//
//  ResponseModel.m
//  kuaichengwuliu
//
//  Created by zhz on 16/5/9.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "ResponseModel.h"

@implementation ResponseModel
-(BOOL)isSuccess
{
    return [self.code isEqualToString:@"1"];
    
}
@end
