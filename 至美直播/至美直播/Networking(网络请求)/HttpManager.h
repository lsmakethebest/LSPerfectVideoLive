//
//  HttpManager.h
//  AFN3.0
//
//  Created by 刘松 on 2017/1/5.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SharedHttpManager [HttpManager sharedHttpManager]

/*! 判断是否有网 */
#ifndef kIsHaveNetwork
#define kIsHaveNetwork   [HttpManager isHaveNetwork]
#endif

/*! 判断是否为手机网络 */
#ifndef kIs3GOr4GNetwork
#define kIs3GOr4GNetwork [HttpManager is3GOr4GNetwork]
#endif

/*! 判断是否为WiFi网络 */
#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork   [HttpManager isWiFiNetwork]
#endif


/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, NetworkStatus)
{
    //未知网络
    NetworkStatusUnknown           = 0,
    // 没有网络
    NetworkStatusNotReachable,
    //手机 3G/4G 网络
    NetworkStatusReachableViaWWAN,
    // wifi 网络 
    NetworkStatusReachableViaWiFi
};


/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, HttpRequestType)
{
    // get请求
    HttpRequestTypeGet = 0,
    // post请求
    HttpRequestTypePost,
    // put请求
    HttpRequestTypePut,
    // delete请求
    HttpRequestTypeDelete
};


/*! 定义请求成功的 block */
typedef void (^Success)(NSDictionary* response);
/*! 定义请求失败的 block */
typedef void (^Failure)(NSError *error);
/*! 定义上传下载进度 block */
typedef void(^UploadDownloadProgress)(CGFloat progress);
/*! 实时监测网络状态的 block */
typedef void(^NetworkStatusBlock)(NetworkStatus status);




@interface HttpManager : NSObject


/**
 *  POST
 */
+ (void)POSTWithURLString:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure;

/**
 *  GET
 */
+ (void)GETWithURLString:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure;

/**
 *  可传请求类型请求
 */
+(void)RequestWithType:(HttpRequestType)type URLString:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure;


/**
 *  开启网络监测
 */
+ (void)startNetWorkMonitoringWithBlock:(NetworkStatusBlock)networkStatusBlock;


/**
 *  下载文件
 */
+ (NSURLSessionDownloadTask *)DownLoadFileWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters savaPath:(NSString *)savePath resumeData:(NSData*)resumeData progress:(UploadDownloadProgress)progress success:(Success)success failure:(Failure)failure;

/**
 *  上传视频文件
 */
+ (NSURLSessionDataTask*)UploadVideoWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters videoPath:(NSString*)videoPath success:(Success)success failur:(Failure)failure progress:(UploadDownloadProgress)progress;

/**
 *  上传多张图片
 */
+(NSURLSessionDataTask*)UploadImagesWithURLString:(NSString*)URLString parameters:(NSDictionary *)parameters images:(NSArray*)imageArray success:(Success)success failur:(Failure)failure progress:(UploadDownloadProgress)progress;


/**
 *   取消 所有Http 请求
 */
+(void)cancelAllRequest;

/*
 *  取消指定 URL 的 Http 请求
 */
+ (void)cancelRequestWithURLString:(NSString *)URLString;


/**
 *  是否有网
 */
+ (BOOL)isHaveNetwork;

/**
 *  是否是手机网络
 */
+ (BOOL)is3GOr4GNetwork;

/**
 *  是否是 WiFi 网络
 */
+ (BOOL)isWiFiNetwork;

/**
 *  设置cookie
 */
+ (void)setCookie:(NSString *)url;

/**
 * 设置公共参数
 */
+ (id)setPublicParams:(id)params;


//单例
+ (instancetype)sharedHttpManager;


@end
