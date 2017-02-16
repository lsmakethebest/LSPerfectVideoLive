//
//  NewsModel.h
//  LSScrollPage
//
//  Created by ls on 16/1/2.
//  Copyright © 2016年 song. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  LSFooterStateHidden,
  LSFooterStateNormal,
  LSFooterStateNoMoreData

} LSFooterState;
@interface LSModel : NSObject
/*
 每一页面的名称
 */
@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *orderStatus;
@property (nonatomic,assign) LSFooterState footerState;


/*
 存放每一页面新闻的数组
 */
@property(nonatomic, strong) NSMutableArray *dataList;
@end
