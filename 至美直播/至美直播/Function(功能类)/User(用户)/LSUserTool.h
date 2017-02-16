
//
//  LSUserTool
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/29.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "UserModel.h"

@interface LSUserTool : NSObject

singalton_h(UserTool);
@property(nonatomic,strong) UserModel *userModel;

//设置新model并保存
-(void)saveUserInfo:(UserModel*)userInfo;

//退出登录
-(void)exit;

//保存当前model到本地
-(void)save;

@end
