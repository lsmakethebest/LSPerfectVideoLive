

//
//  URLKey.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/28.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#ifndef URLKey_h
#define URLKey_h


#define  BASE_URL @"http://www.itiapp.cn/zhimei/php/"

#define LSQNFileHost  @"http://7xrrzh.com1.z0.glb.clouddn.com/"



//后台获取融云token
#define  LSGetToken  @"RCAPI/rongyun.php"

//RTMP推流地址
#define LSRtmpPublishURL @"rtmp://pili-publish.itiapp.cn<Hub>/?e=<ExpireAt>&token=<Token>"

//七牛获取stream信息
#define LSRtmpLiveURL @"pili-sdk-php/example/createStream.php"

//七牛创建流信息
#define LSCreateStreamURL @"pili-sdk-php/example/createStream.php"

//获取短视频列表
#define LSGetShortVideoURL  @"getVideos.php"


//上传视频key到服务器
#define LSInsertVideoKeyURL  @"insertVideo.php"

#endif /* URLKey_h */
