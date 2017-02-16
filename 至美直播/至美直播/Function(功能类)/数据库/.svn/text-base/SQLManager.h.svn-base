//
//  SQLManager.h
//  driver
//
//  Created by 刘松 on 16/7/27.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLManager : NSObject

//类方法创建
+ (instancetype)sharedSQLManager;

/**
 *  创建数据表
 *
 *  @param sql sql语句
 *
 *  @return 返回 创建是否成功的标识
 */
-(BOOL)creatTabel:(NSString*)sql;
/**
 *  使用实体类型进行自动建表
 *
 *  @param tableName 表名称
 *  @param modelType 实体类型 用于自动检索实体的属性
 *
 *  @return 返回bool
 */
-(BOOL)createTabel:(NSString*)tableName modelType:(Class)modelType;
/**
 *  增删改语句通用执行方法
 *
 *  @param sql 传入sql语句
 *
 *  @return 返回bool值
 */
-(BOOL)execute:(NSString*)sql;

/**
 *  执行查询
 *
 *  @param sql 传入sql语句
 *
 *  @return 返回 数组<字典> 字典的键与数据库字段名相同
 */
-(NSMutableArray*)executeQuery:(NSString*)sql;

/**
 *  插入一个实体对象到某一张表
 *
 *  @param model     实体对象
 *  @param tableName 表名
 *
 *  @return 返回bool值
 */
-(BOOL)insertModel:(id)model TableName:(NSString *)tableName;

@end
