//
//  AlipayOrder.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/8.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayOrder : NSObject


// 签约合作者身份ID
@property(nonatomic, copy) NSString * partner;

// 签约卖家支付宝账号
@property(nonatomic, copy) NSString * seller;

// 商户网站唯一订单号
@property(nonatomic, copy) NSString * tradeNO;

// 商品名称
@property(nonatomic, copy) NSString * productName;

// 商品详情
@property(nonatomic, copy) NSString * productDescription;

//商品金额
@property(nonatomic, copy) NSString * amount;

//服务器异步通知页面路径
@property(nonatomic, copy) NSString * notifyURL;

//服务器接口名称，固定值
@property(nonatomic, copy) NSString * service;

//支付类型固定值
@property(nonatomic, copy) NSString * paymentType;

//参数编码固定值
@property(nonatomic, copy) NSString * inputCharset;
// 设置未付款交易的超时时间
// 默认30分钟，一旦超时，该笔交易就会自动被关闭。
// 取值范围：1m～15d。
// m-分钟，h-小时，d-天，1c-当天（无论交易何时创建，都在0点关闭）。
// 该参数数值不接受小数点，如1.5h，可转换为90m。
@property(nonatomic, copy) NSString * itBPay;

// 支付宝处理完请求后，当前页面跳转到商户指定页面的路径，可空
@property(nonatomic, copy) NSString * showUrl;


@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;
@end
