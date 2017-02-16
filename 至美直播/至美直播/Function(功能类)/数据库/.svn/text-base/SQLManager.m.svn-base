

//
//  SQLManager.m
//  driver
//
//  Created by 刘松 on 16/7/27.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "SQLManager.h"

#import <sqlite3.h>

#define SQLFielPath                                                            \
  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,  \
                                       YES) firstObject]
#define DataBaseName @"database.sqlite"
static SQLManager *instance = nil;

@interface SQLManager ()

    {
  sqlite3 *sql3;
}

@end

@implementation SQLManager

+ (instancetype)sharedSQLManager {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [super allocWithZone:zone];
  });
  return instance;
}

- (BOOL)creatTabel:(NSString *)sql {
  return [self execute:sql];
}

- (BOOL)createTabel:(NSString *)tableName modelType:(Class)modelType {
  NSMutableString *sql = [NSMutableString
      stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('id' INTEGER PRIMARY "
                       @"KEY AUTOINCREMENT,",
                       tableName];
  NSArray *names =
      [NSArray arrayWithArray:[self allPropertyNameInClass:modelType]];
  for (NSDictionary *dic in names) {
    NSString *name = dic[@"name"];
    NSString *type = dic[@"type"];
    [sql appendString:[NSString stringWithFormat:@"'%@' %@ ,", name, type]];
  }
  NSString *realSql = [sql substringToIndex:sql.length - 1];
  realSql = [realSql stringByAppendingString:@");"];
  NSLog(@"%@", realSql);

  return [self execute:realSql];
}
- (BOOL)execute:(NSString *)sql {
  [self open];
  int res = sqlite3_exec(sql3, sql.UTF8String, NULL, NULL, NULL);
  [self close];
  return !res;
}

- (NSMutableArray *)executeQuery:(NSString *)sql {
  [self open];
  sqlite3_stmt *stmt = nil;
  NSMutableArray *arr = [NSMutableArray array];
  int res = sqlite3_prepare_v2(sql3, sql.UTF8String, -1, &stmt, NULL);
  if (res == SQLITE_OK) {
    while (sqlite3_step(stmt) == SQLITE_ROW) {
      int count = sqlite3_column_count(stmt);
      NSMutableDictionary *dic = [NSMutableDictionary dictionary];
      for (int i = 0; i < count; i++) {
        const char *columName = sqlite3_column_name(stmt, i);
        const char *value = (const char *)sqlite3_column_text(stmt, i);
        if (value != NULL) {
          NSString *columValue = [NSString stringWithUTF8String:value];
          [dic setObject:columValue
                  forKey:[NSString stringWithUTF8String:columName]];
        } else {
          [dic setObject:@"" forKey:[NSString stringWithUTF8String:columName]];
        }
      }
      [arr addObject:dic];
    }
    sqlite3_finalize(stmt);
    [self close];
    return arr;

  }
  else {
    return nil;
  }
  return nil;
}
- (BOOL)insertModel:(id)model TableName:(NSString *)tableName {
  NSDictionary *dic = [self DictionaryFromModel:model];
  NSMutableString *keys = [NSMutableString string];
  NSMutableString *values = [NSMutableString string];
  for (int i = 0; i < dic.count; i++) {
    NSString *key = dic.allKeys[i];
    NSString *value = dic.allValues[i];
    [keys appendFormat:@"%@,", key];
    [values appendFormat:@"'%@',", value];
  }
  NSString *sql =
      [NSString stringWithFormat:@"insert into %@(%@) values(%@)", tableName,
                                 [keys substringToIndex:keys.length - 1],
                                 [values substringToIndex:values.length - 1]];
  NSLog(@"%@", sql);
  return ![self execute:sql];
}

//********************************************* 本类辅助函数
//***************************************//

- (BOOL)open {
  //    NSString *fileName = [SQLFielPath
  //    stringByAppendingPathComponent:DataBaseName];
  NSString *fileName =
    [[NSBundle mainBundle] pathForResource:@"kcwl_areas.sql" ofType:nil];

  NSLog(@"path=%@", fileName);

  if (sql3) {
    NSLog(@"数据库已开启!!!");
  }
  int result = sqlite3_open(fileName.UTF8String, &sql3);
  if (result == SQLITE_OK) {
    NSLog(@"数据库打开成功!");
    return YES;
  } else {
    NSLog(@"数据库打开失败!,code = %d", result);
    return NO;
  }
}
- (BOOL)close {
  int result = sqlite3_close(sql3);
  if (result == SQLITE_OK) {
    NSLog(@"数据库关闭成功");
    sql3 = nil;
    return YES;
  } else {
    NSLog(@"数据库关闭失败.code:%d", result);
    return NO;
  }
}
//字典与对象的转换函数
//对象转换为字典
- (NSDictionary *)DictionaryFromModel:(id)model {
  NSMutableDictionary *dic = [NSMutableDictionary dictionary];
  Class modelClass = object_getClass(model);
  unsigned int count = 0;
  objc_property_t *pros = class_copyPropertyList(modelClass, &count);

  for (int i = 0; i < count; i++) {
    objc_property_t pro = pros[i];
    NSString *name = [NSString stringWithFormat:@"%s", property_getName(pro)];
    id value = [model valueForKey:name];
    if (value != nil) {
      [dic setObject:value forKey:name];
    }
  }
  free(pros);
  return dic;
}
//********************************************* 属性动态解析部分
//***************************************//
// Runtime辅助函数解析类的属性特征等行为
//获取属性的特征值
- (NSString *)attrValueWithName:(NSString *)name
                     InProperty:(objc_property_t)pro {
  unsigned int count = 0;
  objc_property_attribute_t *attrs = property_copyAttributeList(pro, &count);
  for (int i = 0; i < count; i++) {
    objc_property_attribute_t attr = attrs[i];
    if (strcmp(attr.name, name.UTF8String) == 0) {
      return [NSString stringWithUTF8String:attr.value];
    }
  }
  free(attrs);
  return nil;
}

//获取属性的值
- (id)valueOfproperty:(objc_property_t)pro cls:(Class)cls {
  Ivar ivar = class_getInstanceVariable(
      cls, [self attrValueWithName:@"V" InProperty:pro].UTF8String);
  return object_getIvar(cls, ivar);
}

//获取类的所有属性名称与类型
- (NSArray *)allPropertyNameInClass:(Class)cls {
  NSMutableArray *arr = [NSMutableArray array];
  unsigned int count;
  objc_property_t *pros = class_copyPropertyList(cls, &count);
  for (int i = 0; i < count; i++) {
    NSString *name =
        [NSString stringWithFormat:@"%s", property_getName(pros[i])];
    NSString *type = [self attrValueWithName:@"T" InProperty:pros[i]];
    //类型转换
    if ([type isEqualToString:@"q"] || [type isEqualToString:@"i"]) {
      type = @"INTEGER";
    } else if ([type isEqualToString:@"f"] || [type isEqualToString:@"d"]) {
      type = @"REAL";
    } else {
      type = @"TEXT";
    }
    NSDictionary *dic = @{ @"name" : name, @"type" : type };
    [arr addObject:dic];
  }
  free(pros);

  return arr;
}

- (void)closeDB {
  int result = sqlite3_close(sql3);
  if (result == SQLITE_OK) {
    NSLog(@"数据库关闭成功");
    sql3 = nil;
  } else {
    NSLog(@"数据库关闭失败.code:%d", result);
  }
}
@end
