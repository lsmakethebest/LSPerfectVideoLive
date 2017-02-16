//
//  AlipayTool.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/8.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

@interface AlipayTool : NSObject

+(instancetype)sharedAlipayTool;
- (void)startPayWithOrderStringWithTradeNO:(NSString *)tradeNO productName:(NSString *)productName productDescription:(NSString *)productDescription price:(NSString *)price;
- (void)startPayWithOrderStringWithOrdertring:(NSString*)orderString;
-(void)handleSourceApplicationResult:(NSURL*)url;

@end
