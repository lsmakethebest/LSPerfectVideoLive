//
//  ResponseModel.h
//  kuaichengwuliu
//
//  Created by zhz on 16/5/9.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseModel : NSObject

@property(copy,nonatomic)NSString * code;
@property(copy,nonatomic)NSString *message;
@property(assign,nonatomic,readonly)BOOL isSuccess;

@end
