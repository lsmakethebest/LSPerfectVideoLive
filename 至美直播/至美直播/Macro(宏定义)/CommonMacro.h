

//
//  CommonMacro.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/28.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#define WeakSelf __weak typeof(self) weakSelf=self

//版本号
#define KCBundleVersion [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"]

//沙盒快速设置
#define KCUserDefaultSetObjectWithKey(obj,key)  [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]

//快速取出值
#define KCUserDefaultGetObjectForKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

//通知中心
#define LSNotificationCenter [NSNotificationCenter defaultCenter]



//转字符串
#define StringFromInt(value) [NSString stringWithFormat:@"%d",value]
#define StringFromDouble(value) [NSString stringWithFormat:@"%lf",value]


#define KCPushWithClassString(value) [self.navigationController pushViewController:[[NSClassFromString((value)) alloc]init] animated:YES]


//打电话
#define KCCall_Service_Phone  [[UIApplication sharedApplication]openURL:[NSURL URLWithString:StringFormat(@"telprompt://",KCCALL_PHONE_NUMBER)]]


// 系统版本
#define IOS_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]


// 屏幕尺寸
#define SCREEN_W    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H    ([UIScreen mainScreen].bounds.size.height)

// 类初始化
#define CLASS_INIT(x)     [[NSClassFromString(x) alloc] init]


// 字符串拼接
#define StringFormat(a,b) [NSString stringWithFormat:@"%@%@",a,b]
#define StringFormatThree(a,b,c) [NSString stringWithFormat:@"%@%@%@",a,b,c]


#define  MaxY(view)   CGRectGetMaxY(view.frame)
#define  MinY(view)   CGRectGetMinY(view.frame)

#define  MaxX(view)   CGRectGetMaxX(view.frame)
#define  MinX(view)   CGRectGetMinX(view.frame)


#define LSLocalizedStringWithKey(key)  NSLocalizedString(key, nil) 






#endif /* CommonMacro_h */
