//
//  KCCheckVersion.m
//  driver
//
//  Created by 刘松 on 16/7/25.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCCheckVersion.h"

@interface KCCheckVersion ()

@property(nonatomic, copy) NSString *versionCode;
@property(nonatomic, assign) BOOL isCoerce;
@property(nonatomic, copy) NSString *updateUrl;

@end
static KCCheckVersion *instance = nil;

@implementation KCCheckVersion
+ (instancetype)sharedInstance {
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
- (void)becomeActive {
  if (self.isCoerce) {
    if ([self.versionCode isEqualToString:KCVersionCode]) {
      exit(0);
    }
  }
}
- (void)checkNewVersion {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  //  // 注意 接口版本
  NSString *app_Version = KCVersion;

  params[@"versionNo"] = app_Version;
  params[@"versionCode"] = KCVersionCode;
  params[@"osType"] = @1;
  [HttpManager POST:KCUpdateVersion_URL
      parameters:params
      success:^(NSDictionary *response) {
        if ([ResponseModel mj_objectWithKeyValues:response].isSuccess) {

          if ([response[@"result"][@"isUpdate"] intValue] == 1) {
            self.updateUrl = response[@"result"][@"updateUrl"];
            self.isCoerce = [response[@"result"][@"isCoerce"] intValue] == 1;
            [UIAlertView
                    showWithTitle:@"检测到新版本"
                          message:response[@"result"][@"updateDescription"]
                cancelButtonTitle:@"取消"
                otherButtonTitles:@"去下载"
                            block:^(NSInteger buttonIndex) {
                              if (buttonIndex == 1) {
                                [[UIApplication sharedApplication]
                                    openURL:[NSURL
                                                URLWithString:self.updateUrl]];
                                //  // 注意 接口版本
                                self.versionCode = KCVersionCode;
                              } else if (buttonIndex == 0) {
                                if (self.isCoerce) {
                                  exit(0);
                                }
                              }
                            }];
          }
        }
      }
      failure:^(NSError *error){

      }];
}
@end
