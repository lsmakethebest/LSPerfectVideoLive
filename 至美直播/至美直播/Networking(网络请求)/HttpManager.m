



//
//  HttpManager.m
//  AFN3.0
//
//  Created by 刘松 on 2017/1/5.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "HttpManager.h"

#import <AFNetworking.h>

#import <AFNetworkActivityIndicatorManager.h>


#define HttpManagerDebug


// 调试信息
#ifdef HttpManagerDebug
#define LSLog(fmt, ...) NSLog((@"debug %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define LSLog(...)
#endif



#define TimeOut 15



@interface HttpManager ()

@property(nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,strong) NSMutableArray *tasks;

@end




@implementation HttpManager


static HttpManager *instance = nil;

+ (instancetype)sharedHttpManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[self alloc]init];
        instance.manager= [self createManagerAndSetting];
        instance.tasks=[NSMutableArray array];
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

#pragma mark - GET
+ (void)GETWithURLString:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure
{
    [self RequestWithType:HttpRequestTypeGet URLString:URLString parameters:parameters success:success failure:failure];
}


#pragma mark - POST
+ (void)POSTWithURLString:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure
{
    [self RequestWithType:HttpRequestTypePost URLString:URLString parameters:parameters success:success failure:failure];
}


#pragma mark - 公共请求
+(void)RequestWithType:(HttpRequestType)type URLString:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure
{
    
  __block  NSURLSessionTask *sessionTask = nil;
    
    parameters=[self setPublicParams:parameters];
    [self setCookie:URLString];
    
//    AFHTTPSessionManager *manager =SharedHttpManager.manager;
    AFHTTPSessionManager *manager=[self createManagerAndSetting];
    
    __weak __typeof(SharedHttpManager) weakSelf = SharedHttpManager;
    
    if (type == HttpRequestTypeGet) {
        sessionTask=  [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success([self dictionaryWithData:responseObject]);
            }
            [weakSelf.tasks removeObject:sessionTask];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            [weakSelf.tasks removeObject:sessionTask];
        }];
    }
    else if (type == HttpRequestTypePost){
        sessionTask             =  [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success([self dictionaryWithData:responseObject]);
            }
            [weakSelf.tasks removeObject:sessionTask];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            [weakSelf.tasks removeObject:sessionTask];
        }];
        
    }
    else if (type == HttpRequestTypePut){
        sessionTask=  [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success([self dictionaryWithData:responseObject]);
            }
            [weakSelf.tasks removeObject:sessionTask];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            [weakSelf.tasks removeObject:sessionTask];
        }];
    }
    else if (type == HttpRequestTypeDelete){
        sessionTask= [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success([self dictionaryWithData:responseObject]);
            }
            [weakSelf.tasks removeObject:sessionTask];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            [weakSelf.tasks removeObject:sessionTask];
        }];
    }
    
    if (sessionTask)
    {
        [SharedHttpManager.tasks addObject:sessionTask];
    }
}



#pragma mark -  上传多张图片

+(NSURLSessionDataTask*)UploadImagesWithURLString:(NSString*)URLString parameters:(NSDictionary *)parameters images:(NSArray*)imageArray success:(Success)success failur:(Failure)failure progress:(UploadDownloadProgress)progress
{
   __block NSURLSessionDataTask *sessionTask = nil;
    parameters=[self setPublicParams:parameters];
    [self setCookie:URLString];
    AFHTTPSessionManager *manager =SharedHttpManager.manager;
    
    __weak __typeof(SharedHttpManager) weakSelf = SharedHttpManager;
    
    sessionTask= [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
                  {
                      for (UIImage *image in imageArray){
                          //压缩方法可以自己修改
                          NSData *imgData=[self dataCompressWithImage:image scale:2];
                          [formData appendPartWithFileData:imgData  name:@"fileName" fileName:[self createFileNameWithFiletType:@"jpg"] mimeType:@"image/jpeg"];
                      }
                  } progress:^(NSProgress * _Nonnull uploadProgress) {
                      if (progress){
                          progress(1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
                      }
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      if (success){
                          success([self dictionaryWithData:responseObject]);
                      }
                       [weakSelf.tasks removeObject:sessionTask];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      if (failure){
                          failure(error);
                      }
                       [weakSelf.tasks removeObject:sessionTask];
                  }];
    if (sessionTask)
    {
        [SharedHttpManager.tasks addObject:sessionTask];
    }
    return  sessionTask;
}

#pragma mark - 上传视频文件
+ (NSURLSessionDataTask*)UploadVideoWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters videoPath:(NSString*)videoPath success:(Success)success failur:(Failure)failure progress:(UploadDownloadProgress)progress
{
  __block  NSURLSessionDataTask *sessionTask = nil;
    parameters=[self setPublicParams:parameters];
    [self setCookie:URLString];
    
    AFHTTPSessionManager *manager =SharedHttpManager.manager;
    __weak __typeof(SharedHttpManager) weakSelf = SharedHttpManager;
    
    sessionTask= [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[self cteateURLWithURlString:videoPath] name:@"video" fileName:[self createFileNameWithFiletType:@".mp4"] mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress){
            progress(1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            success([self dictionaryWithData:responseObject]);
        }
         [weakSelf.tasks removeObject:sessionTask];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(error);
        }
         [weakSelf.tasks removeObject:sessionTask];
    }];
    
    
    
    if (sessionTask)
    {
        [SharedHttpManager.tasks addObject:sessionTask];
    }
    return sessionTask;
}


#pragma mark - 文件下载
+ (NSURLSessionDownloadTask *)DownLoadFileWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters savaPath:(NSString *)savePath resumeData:(NSData *)resumeData progress:(UploadDownloadProgress)progress success:(Success)success failure:(Failure)failure
{

  __block  NSURLSessionDownloadTask *sessionTask = nil;
    parameters=[self setPublicParams:parameters];
    [self setCookie:URLString];
    AFHTTPSessionManager *manager =SharedHttpManager.manager;
    
    __weak __typeof(SharedHttpManager) weakSelf = SharedHttpManager;
    
    if (resumeData!=nil) {
        
        sessionTask= [manager downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
            /*! 回到主线程刷新UI */
            dispatch_async(dispatch_get_main_queue(), ^{
                if (progress){
                    progress(1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
                }
            });
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            if (!savePath){
                NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                //默认路径
                return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            }
            else{
                return [NSURL fileURLWithPath:savePath];
            }
        }completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            if (error == nil){
                if (success){
                    /*! 返回完整路径 */
                    NSMutableDictionary *pathDict=[NSMutableDictionary dictionary];
                    pathDict[@"filePath"]=filePath.absoluteString;
                    success(pathDict);
                }
            }
            else{
                if (failure){
                    failure(error);
                }
            }
            [weakSelf.tasks removeObject:sessionTask];
        }];
        
        if (sessionTask){
            [SharedHttpManager.tasks addObject:sessionTask];
        }
        [sessionTask resume];
        return  sessionTask;
    }
    
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[self cteateURLWithURlString:URLString]];
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        /*! 回到主线程刷新UI */
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress){
                progress(1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!savePath){
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            //默认路径
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }
        else{
            return [NSURL fileURLWithPath:savePath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error == nil){
            if (success){
                /*! 返回完整路径 */
                NSMutableDictionary *pathDict=[NSMutableDictionary dictionary];
                pathDict[@"filePath"]=filePath.absoluteString;
                success(pathDict);
            }
        }
        else{
            if (failure){
                failure(error);
            }

        }
        [weakSelf.tasks removeObject:sessionTask];
    }];
    
    if (sessionTask)
    {
        [SharedHttpManager.tasks addObject:sessionTask];
    }
    /*! 开始启动任务 */
    [sessionTask resume];
    return sessionTask;
}

#pragma mark - 网络状态监测
+ (void)startNetWorkMonitoringWithBlock:(NetworkStatusBlock)networkStatusBlock
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        NetworkStatus  newNetworkStatus;
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                LSLog(@"未知网络");
                newNetworkStatus=NetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                LSLog(@"没有网络");
                newNetworkStatus=NetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                LSLog(@"手机自带网络");
                newNetworkStatus=NetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                LSLog(@"wifi 网络");
                newNetworkStatus=NetworkStatusReachableViaWiFi;
                break;
        }
        if (networkStatusBlock) {
            networkStatusBlock(newNetworkStatus);
        }
        
    }];
    [manager startMonitoring];
}


/*!
 *  是否有网
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)isHaveNetwork
{
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

/*!
 *  是否是手机网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)is3GOr4GNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

/*!
 *  是否是 WiFi 网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}


#pragma mark - 取消 Http 请求
+(void)cancelAllRequest
{
    // 锁操作
    @synchronized(self)
    {
        [SharedHttpManager.tasks  enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [SharedHttpManager.tasks removeAllObjects];
    }

}

#pragma mark - 取消指定 URL 的 Http 请求
+(void)cancelRequestWithURLString:(NSString *)URLString
{
    if (URLString.length<=0)
    {
        return;
    }
    
    @synchronized (self){
        [SharedHttpManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URLString]){
                [task cancel];
                [SharedHttpManager.tasks removeObject:task];
                *stop = YES;
            }
        }];
    }

}


#pragma mark - 辅助类
+(AFHTTPSessionManager*)createManagerAndSetting
{
    
    AFHTTPSessionManager *manager=  [AFHTTPSessionManager manager];
    
    /*! 打开状态栏的等待菊花 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    /*! 设置相应的缓存策略：此处选择不用加载也可以使用自动缓存【注：只有get方法才能用此缓存策略，NSURLRequestReturnCacheDataDontLoad】 */
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    /*! 这里是去掉了键值对里空对象的键值 */
    //    response.removesKeysWithNullValues = YES;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求队列的最大并发数
    //manager.operationQueue.maxConcurrentOperationCount = 5;
    
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = TimeOut;;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", @"image/*", nil];
    
    
    /*! https 参数配置 */
    //采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    
    //    ! 自定义的CA证书配置如下：
    /*! 自定义security policy, 先前确保你的自定义CA证书已放入工程Bundle */
    /*!
     https://api.github.com网址的证书实际上是正规CADigiCert签发的, 这里把Charles的CA根证书导入系统并设为信任后, 把Charles设为该网址的SSL Proxy (相当于"中间人"), 这样通过代理访问服务器返回将是由Charles伪CA签发的证书.
     */
    /*
     NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
     AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
     policy.allowInvalidCertificates = YES;
     manager.securityPolicy = policy;
     */
    
    
    // 如果服务端使用的是正规CA签发的证书, 那么以上代码则可以去掉
    return manager;
    
}


#pragma mark - 将图片压缩成data
+ (NSData *)dataCompressWithImage:(UIImage *)sourceImage scale:(CGFloat)scale
{
    CGSize imageSize = sourceImage.size;
    float width = imageSize.width;
    float height = imageSize.height;
    float targetWidth = width/scale;
    float targetHeight = height/scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImageJPEGRepresentation(newImage,1.0);
    return data;
}


#pragma mark -  根据时间戳创建文件名称
+(NSString*)createFileNameWithFiletType:(NSString*)fileType
{
    //根据当前时刻，为图片起名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName=[NSString stringWithFormat:@"%@.%@",str,fileType];
    return fileName;
    
}

#pragma mark -  根据urlstring创建NSURL
+(NSURL*)cteateURLWithURlString:(NSString*)URLString
{
    return [NSURL URLWithString:[self strUTF8Encoding:URLString]];
}


#pragma mark - url 中文格式化
+ (NSString *)strUTF8Encoding:(NSString *)str
{
    //ios9适配的话 打开第一个
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0){
        return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    }
    else{
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}


#pragma mark - NSData转化为字典
+ (NSDictionary *)dictionaryWithData:(NSData *)data {
    NSDictionary *dictionary =
    [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if (dictionary) {
        return dictionary;
    }
    return nil;
}


#pragma mark - 设置cookie
+ (void)setCookie:(NSString *)url
{
    // 定义 cookie 要设定的 host
    NSURL *cookieHost = [NSURL URLWithString:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (dic.allKeys.count==0) {
        return;
    }
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 设定 cookie
        NSHTTPCookie *cookie = [NSHTTPCookie
                                cookieWithProperties:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 [cookieHost host], NSHTTPCookieDomain,
                                 [cookieHost path], NSHTTPCookiePath,
                                 key,NSHTTPCookieName,
                                 obj,NSHTTPCookieValue,
                                 nil
                                 ]];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }];
}


#pragma mark - 设置公共参数
+ (id)setPublicParams:(id)params
{
    NSMutableDictionary *newParams =
    [[NSMutableDictionary alloc] initWithDictionary:params];
    return newParams;
}

@end
