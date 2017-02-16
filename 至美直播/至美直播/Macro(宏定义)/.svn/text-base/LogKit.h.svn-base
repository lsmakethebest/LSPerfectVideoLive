
//
//  LogKit.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/28.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#include <stdio.h>

#ifndef IOSDemos_LogKit_h
#define IOSDemos_LogKit_h


// 调试信息
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"debug %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

// 错误信息
#ifdef DEBUG
#define ELog(fmt, ...) NSLog((@"error %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ELog(...)
#endif

// 警告信息
#ifdef DEBUG
#define WLog(fmt, ...) NSLog((@"warning %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define WLog(...)
#endif

#endif
