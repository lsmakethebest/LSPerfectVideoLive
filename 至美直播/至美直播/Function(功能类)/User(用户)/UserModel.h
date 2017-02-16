//
//  UserModel.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/28.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ResponseModel.h"
@interface UserModel : ResponseModel

@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *headicon;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,assign) NSInteger level;




@end

