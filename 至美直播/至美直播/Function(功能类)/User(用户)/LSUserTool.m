


//
//  KCUserTool.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/29.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "LSUserTool.h"
#import "UserModel.h"

#define UserInfoKey @"USERINFO"

@interface LSUserTool ()

@end
@implementation LSUserTool

singalton_m(UserTool);

-(instancetype)init
{
    if (self=[super init]) {
        self.userModel= [UserModel mj_objectWithKeyValues: KCUserDefaultGetObjectForKey(UserInfoKey)];
        
    }
    return self;
}
//保存用户信息
-(void)saveUserInfo:(UserModel*)userInfo
{
    self.userModel=userInfo;
    KCUserDefaultSetObjectWithKey([self.userModel mj_keyValues], UserInfoKey);
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//退出登录
-(void)exit
{
    self.userModel = nil;
    [self  saveUserInfo:nil];
}


-(void)save
{
    KCUserDefaultSetObjectWithKey([self.userModel mj_keyValues], UserInfoKey);
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
