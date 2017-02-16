



//
//  LSRecordingViewController.m
//  至美直播
//
//  Created by 刘松 on 2017/1/4.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSRecordingViewController.h"

#import <QiniuSDK.h>
#import <GPUImage.h>
#import "LSPlayViewController.h"

#import "LSProgressButton.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "GPUImageBeautifyFilter.h"


@interface LSRecordingViewController ()<GPUImageVideoCameraDelegate,AVPlayerViewControllerDelegate>


{
    GPUImageVideoCamera *videoCamera;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageMovieWriter *movieWriter;
    GPUImageView *filteredVideoView;
    
    CALayer *_focusLayer;

}


//标志是否正在录制   没录制如果直接点关闭会闪退
@property (nonatomic,assign) BOOL isRecord;

//截取第一帧图片使用
@property (nonatomic,assign) BOOL start;

@property (nonatomic,weak) UIButton *uploadButton;

@property (nonatomic,weak) UIButton *torchButton;

@property (nonatomic,copy) NSString *pathToMovie;

@property (nonatomic,copy) NSString *videoKey;
@property (nonatomic,copy) NSString *imageKey;

@property(nonatomic,strong) AVPlayer *player;

@property (nonatomic,weak) AVPlayerItem *playerItem;

@property (nonatomic,weak) UIButton *deleteButton;

@property (nonatomic,weak) UIButton *downloadButton;

@property (nonatomic,weak) AVPlayerLayer *playerLayer;

@property (nonatomic,weak) AVPlayerLayer *lastLayer;

@property (nonatomic,weak) UIView *changeFilterView;


@end


@implementation LSRecordingViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    

    
    self.pathToMovie  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.mp4"];
    
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    
  
    
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
//    videoCamera.videoCaptureConnection.videoOrientation;
//    [_videoDataOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    
    // 设置前置的时候不是镜像
    videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    // 设置后置的时候不是镜像
    videoCamera.horizontallyMirrorRearFacingCamera = NO;

    
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [videoCamera addAudioInputsAndOutputs];
    
    
    filter = [[GPUImageBeautifyFilter alloc] init];
    filteredVideoView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    //把滤镜效果加给摄像头
    [videoCamera addTarget:filter];
    
    //把摄像头上的图像给GPUImageView显示出来
    [filter addTarget:filteredVideoView];
    [videoCamera startCameraCapture];
//    videoCamera.delegate=self;
    
    
    
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraViewTapAction:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    [filteredVideoView addGestureRecognizer:singleFingerOne];
    [self.view addSubview:filteredVideoView];
    
    [self addSomeView];
    
}
-(void)closeView
{
    if (self.isRecord) {
        [self stopRecording:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) addSomeView{
    
    
    CGFloat y=30;
    
    CGFloat width=35;
    CGFloat margin=10;
    
    UIButton *close=[[UIButton alloc]init];
    [close setImage:[UIImage imageNamed:@"sv_close_n_26x27_"] forState:UIControlStateNormal];
    close.frame=CGRectMake(SCREEN_W-width-20, y, width, width);
    [close addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
    

    
    
    UIButton *switchButton=[[UIButton alloc]init];
    switchButton.frame=CGRectMake(MinX(close)-width-margin, y, width, width);
    [switchButton addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventTouchUpInside];
    [switchButton setImage:[UIImage imageNamed:@"seed_rotate_23x23_"] forState:UIControlStateNormal];
    [self.view addSubview:switchButton];
    
    
    
    UIButton *torchButton=[[UIButton alloc]init];
    torchButton.frame=CGRectMake(MinX(switchButton)-width-margin, y, width, width);
    [torchButton addTarget:self action:@selector(openTorce:) forControlEvents:UIControlEventTouchUpInside];
    [torchButton setImage:[UIImage imageNamed:@"live_button_flashlight_26x26_"] forState:UIControlStateNormal];
    [torchButton setImage:[UIImage imageNamed:@"live_button_flashlight_off_26x26_"] forState:UIControlStateSelected];
    [self.view addSubview:torchButton];
    self.torchButton=torchButton;

    
    
    
    
    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"sv_soften_h_48x48_"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"sv_soften_h_48x48_"] forState:UIControlStateSelected];
    button.frame=CGRectMake( MinX(close),MaxY(close)+10, width, width);
    [button addTarget:self action:@selector(openFilterSlider:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    

    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(20, MinY(button), 250, width);
    [self.view addSubview:view];
    view.hidden=YES;
    self.changeFilterView=view;
    
    
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(0, 0, 60, width);
    label.text=@"美颜程度";
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=RGB(0xf93265);
    [view addSubview:label];
    
    
    
    
    UISlider *filterSettingsSlider = [[UISlider alloc] initWithFrame:CGRectMake(80, 0, 250-80, width)];
    [filterSettingsSlider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
    filterSettingsSlider.tintColor=RGB(0xf93265);
    filterSettingsSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    filterSettingsSlider.minimumValue = 0.0;
    filterSettingsSlider.maximumValue = 1.0;
    filterSettingsSlider.value = 0.5;
    [view addSubview:filterSettingsSlider];
    
    
    
    
    
    
    CGFloat bottom=0;
    
    CGFloat btnWidth=60;
    
    UIButton *deleteButton=[[UIButton alloc]init];
//    deleteButton.backgroundColor=RandomColor;
    [deleteButton setImage:[UIImage imageNamed:@"shortvideo_down_del"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteVideo) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.frame=CGRectMake(0,SCREEN_H-bottom-btnWidth, btnWidth, btnWidth);
    [self.view addSubview:deleteButton];
    self.deleteButton=deleteButton;
    deleteButton.hidden=YES;
    
    
    
    UIButton *downloadButton=[[UIButton alloc]init];
    [downloadButton setImage:[UIImage imageNamed:@"shortvideo_down_download"] forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(downloadVideo) forControlEvents:UIControlEventTouchUpInside];
    downloadButton.frame=CGRectMake(0+MaxX(deleteButton),SCREEN_H-bottom-btnWidth, btnWidth, btnWidth);
    [self.view addSubview:downloadButton];
    self.downloadButton=downloadButton;
    downloadButton.hidden=YES;
    
    

    
    UIButton *playButton=[[UIButton alloc]init];
    [playButton setImage:[UIImage imageNamed:@"shortvideo_down_send"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(startUpload) forControlEvents:UIControlEventTouchUpInside];
    playButton.frame=CGRectMake(SCREEN_W-75, SCREEN_H-75-bottom, 75, 75);
    playButton.hidden=YES;
    self.uploadButton=playButton;
    [self.view addSubview:playButton];
    
    
    
    
    
    
    
    
    CGFloat startButtonwidth=70;
    
    WeakSelf;
    [LSProgressButton showToView:self.view frame:CGRectMake((SCREEN_W-startButtonwidth)/2, SCREEN_H-startButtonwidth-startButtonwidth, startButtonwidth, startButtonwidth)
                         success:^(LSProgressButtonBlockType type) {
                             
                             if (type==LSProgressButtonBlockTypeStart) {
                                 [weakSelf startRecording:nil];
                             }else if (type==LSProgressButtonBlockTypeEnd){
                                 weakSelf.deleteButton.hidden=NO;
                                 weakSelf.downloadButton.hidden=NO;
                                 weakSelf.uploadButton.hidden=NO;
                                 [weakSelf stopRecording:nil];
                                 [weakSelf playCLick];
                                 [LSNotificationCenter addObserver:weakSelf selector:@selector(playCLick) name:LSBecomeActiveNotification object:nil];
                                 
                             }else{
                                 [weakSelf stopRecording:nil];
                             }
                         }];

}
-(void)openFilterSlider:(UIButton*)btn
{
    self.changeFilterView.hidden=btn.selected;
    btn.selected=!btn.selected;
    
}



#pragma mark - 删除视频
-(void)deleteVideo
{
    [AlertTool showWithViewController:self title:@"要回到拍摄页面吗?" message:@"现在删除会失去已编辑的内容哦" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
        [self.player pause];
        self.player=nil;
        [self.playerLayer removeFromSuperlayer];
        
        self.deleteButton.hidden=YES;
        self.downloadButton.hidden=YES;
        self.uploadButton.hidden=YES;
        
    } cancle:^{
        
    }];
    
}

#pragma mark - 保存视频到本地
-(void)downloadVideo
{
    UISaveVideoAtPathToSavedPhotosAlbum(self.pathToMovie, nil, nil, nil);
    [LSStatusBarHUD showMessage:@"保存成功"];
}

#pragma mark - 上传视频到服务器
-(void)startUpload
{
    [self getToken];
}


#pragma mark - 播放视频
-(void)playCLick
{
    
    
    NSURL *url = [NSURL fileURLWithPath:self.pathToMovie];
    
    AVPlayerItem *item=[AVPlayerItem playerItemWithURL:url];
    AVPlayer *player=[AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *layer=[AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame=self.view.bounds;
    [self.view.layer addSublayer:layer];
    
    [player play];

    if (self.playerLayer) {
        self.lastLayer=self.playerLayer;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.lastLayer removeFromSuperlayer];
    });
    
    
    self.playerItem=item;
    self.playerLayer=layer;

    
    
     [LSNotificationCenter addObserver:self selector:@selector(finishPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    
    [self.view bringSubviewToFront:self.deleteButton];
    [self.view bringSubviewToFront:self.downloadButton];
    [self.view bringSubviewToFront:self.uploadButton];
    

}

- (void)finishPlay:(NSNotification*)note
{
    NSLog(@"object===%@",note.object);
    if (self.playerItem==note.object) {
        [LSNotificationCenter removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification  object:self.playerItem];
        self.playerItem=nil;
        [self playCLick];
    }
}


//旋转摄像头
-(void)switchClick
{
    if (videoCamera.inputCamera.position==AVCaptureDevicePositionBack) {
        self.torchButton.hidden=YES;
        
    }else{
        self.torchButton.hidden=NO;
        self.torchButton.selected=NO;
    }
    [videoCamera rotateCamera];
}

-(void)openTorce:(UIButton*)Btn
{
    if (videoCamera.inputCamera.position == AVCaptureDevicePositionBack) {
        
        if (Btn.selected) {
            [videoCamera.inputCamera lockForConfiguration:nil];
            [videoCamera.inputCamera setTorchMode:AVCaptureTorchModeOff];
            [videoCamera.inputCamera unlockForConfiguration];
            
        }else{
            
            [videoCamera.inputCamera lockForConfiguration:nil];
            [videoCamera.inputCamera setTorchMode:AVCaptureTorchModeOn];
            [videoCamera.inputCamera unlockForConfiguration];
        }
        Btn.selected = !Btn.selected;
        
    }else{
        NSLog(@"当前使用前置摄像头,未能开启闪光灯");
    }
}

- (IBAction)updateSliderValue:(UISlider*)sender
{
    GPUImageBeautifyFilter * filter2=(GPUImageBeautifyFilter*)filter;
    filter2.intensity=sender.value;
}

- (IBAction)stopRecording:(id)sender {
    self.isRecord=NO;
    self.start=NO;
    //[filter removeTarget:movieWriter];
    videoCamera.audioEncodingTarget = nil;
    NSLog(@"Path %@",self.pathToMovie);
    
    [movieWriter finishRecording];
    [filter removeTarget:movieWriter];
}

-(void)getToken
{
    [LSStatusBarHUD showLoading:@"上传中..."];
    [LSHttpManager POST:@"php-sdk/examples/auth.php" parameters:nil success:^(NSDictionary *response) {
        if([response[@"code"] intValue]==1){
            NSLog(@"1111111111111111");
            NSString *token = response[@"token"];
            [self uploadVideoWithToken:token];
            
        }else{
            NSLog(@"222222222");
        }
        
    } failure:^(NSError *error) {
        
    }];

}

-(void)uploadVideoWithToken:(NSString*)token
{
    //华东
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNZone zone0];
    }];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    
    NSLog(@"token===%@",token);
    
    //根据当前时刻，为图片起名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName=[NSString stringWithFormat:@"%@.mp4",str];
    
    [upManager putFile:self.pathToMovie key:fileName token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  if (info.ok) {
                      NSLog(@"信息----%@", info);
                      NSLog(@"结果-----%@", resp);
                      self.videoKey=key;
                      [self uploadImageWithToken:token];
                      
                  }else{
                      NSLog(@"失败原因---%@",info.error.localizedDescription);
                  }
              } option:nil];
    
}

-(void)uploadImageWithToken:(NSString*)token
{
    
    //华东
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNZone zone0];
    }];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    
    NSLog(@"token===%@",token);
    
    //根据当前时刻，为图片起名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName=[NSString stringWithFormat:@"%@.png",str];
    
    
    NSData *data=[self getVideoPreViewImage:[NSURL fileURLWithPath:self.pathToMovie]];
    
    [upManager putData:data key:fileName token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  if (info.ok) {
                      NSLog(@"信息----%@", info);
                      NSLog(@"结果-----%@", resp);
                      self.imageKey=key;
                      [self upload];
                      
                  }else{
                      NSLog(@"失败原因---%@",info.error.localizedDescription);
                  }
              } option:nil];

    
}
-(void)upload
{
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"uid"]=[LSUserTool sharedUserTool].userModel.uid;
    params[@"videokey"]=self.videoKey;
    params[@"username"]=[LSUserTool sharedUserTool].userModel.username;
    params[@"headicon"]=[LSUserTool sharedUserTool].userModel.headicon;
    params[@"thumbnail_image"]=self.imageKey;
    
    [LSHttpManager POST:LSInsertVideoKeyURL parameters:params success:^(NSDictionary *response) {
        NSNumber *numner=response[@"code"];
        if(numner.integerValue==1){
        [LSStatusBarHUD showMessage:@"上传成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [LSStatusBarHUD showMessage:@"上传失败"];
        }
    } failure:^(NSError *error) {
        [LSStatusBarHUD showMessage:@"上传失败"];
    }];
    

    
}

- (IBAction)startRecording:(id)sender {
    
    
    CGSize size= [UIScreen mainScreen].bounds.size;
    
    //   输出视频设置
    NSDictionary *videoSetting =
    @{
      AVVideoCodecKey: AVVideoCodecH264,
      AVVideoWidthKey: @720,
      AVVideoHeightKey: @1280,
      AVVideoScalingModeKey:AVVideoScalingModeResizeAspectFill,
      AVVideoCompressionPropertiesKey: @
          {
          AVVideoAverageBitRateKey: @(size.width*size.height*10.1),
          AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
          AVVideoMaxKeyFrameIntervalKey:@25,//关键帧最大间隔，1为每个都是关键帧，数值越大压缩率越高
          }
      };
    
    
    // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    unlink([self.pathToMovie UTF8String]);
    
    NSURL *movieURL = [NSURL fileURLWithPath:self.pathToMovie];
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(720, 1280)  fileType:AVFileTypeMPEG4 outputSettings:videoSetting];
    
    
    //输出音频设置
    AudioChannelLayout channelLayout;
    memset(&channelLayout, 0, sizeof(AudioChannelLayout));
    channelLayout.mChannelLayoutTag = kAudioChannelLayoutTag_Stereo;
    
    NSDictionary * audioSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [ NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                                    [ NSNumber numberWithInt: 2 ], AVNumberOfChannelsKey,
                                    [ NSNumber numberWithFloat: 16000.0 ], AVSampleRateKey,
                                    [ NSData dataWithBytes:&channelLayout length: sizeof( AudioChannelLayout ) ], AVChannelLayoutKey,
                                    [ NSNumber numberWithInt: 32000 ], AVEncoderBitRateKey,
                                    nil];
    
    
    
//    audioSettings = [NSDictionary dictionaryWithObjectsAndKeys:
//                     [ NSNumber numberWithInt: kAudioFormatMPEG4AAC ], AVFormatIDKey,
//                     [ NSNumber numberWithInt: 1 ], AVNumberOfChannelsKey,
//                     [ NSNumber numberWithFloat: 44100.0 ], AVSampleRateKey,
//                     [ NSNumber numberWithInt: 64000 ], AVEncoderBitRateKey,
//                     nil];
    
    [movieWriter setHasAudioTrack:YES audioSettings:audioSettings];
    //解决有时候 can't write frame
    movieWriter.assetWriter.movieFragmentInterval = kCMTimeInvalid;
    
    movieWriter.encodingLiveVideo = YES;
    movieWriter.shouldPassthroughAudio = YES;
    
    [filter addTarget:movieWriter];
    
    videoCamera.audioEncodingTarget = movieWriter;
    
    [movieWriter startRecording];
    self.isRecord=YES;
    
    
    
    self.start=YES;
}

- (void)setfocusImage{
//    UIImage *focusImage = [UIImage imageNamed:@"room_lianmai_button_cancel_back"];
    UIImage *focusImage = [UIImage imageNamed:@""];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, focusImage.size.width, focusImage.size.height)];
    imageView.image = focusImage;
    CALayer *layer = imageView.layer;
    layer.hidden = YES;
    [filteredVideoView.layer addSublayer:layer];
    _focusLayer = layer;
}


- (void)layerAnimationWithPoint:(CGPoint)point {
    if (_focusLayer) {
        CALayer *focusLayer = _focusLayer;
        focusLayer.hidden = NO;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [focusLayer setPosition:point];
        focusLayer.transform = CATransform3DMakeScale(2.0f,2.0f,1.0f);
        [CATransaction commit];
        CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
        animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0f,1.0f,1.0f)];

        animation.duration = 0.3f;
        animation.repeatCount = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [focusLayer addAnimation: animation forKey:@"animation"];
        // 0.5秒钟延时
        [self performSelector:@selector(focusLayerNormal) withObject:self afterDelay:0.5f];
    }
}


- (void)focusLayerNormal {
    
    filteredVideoView.userInteractionEnabled = YES;
    
    _focusLayer.hidden = YES;
    
}


-(void)cameraViewTapAction:(UITapGestureRecognizer *)tgr
{
    if (tgr.state == UIGestureRecognizerStateRecognized && (_focusLayer == NO || _focusLayer.hidden)) {
        CGPoint location = [tgr locationInView:filteredVideoView];
        [self setfocusImage];
        [self layerAnimationWithPoint:location];
        AVCaptureDevice *device = videoCamera.inputCamera;
        CGPoint pointOfInterest = CGPointMake(0.5f, 0.5f);
        NSLog(@"taplocation x = %f y = %f", location.x, location.y);
        CGSize frameSize = [filteredVideoView frame].size;
        if ([videoCamera cameraPosition] == AVCaptureDevicePositionFront) {
            location.x = frameSize.width - location.x;
            
        }
        pointOfInterest = CGPointMake(location.y / frameSize.height, 1.f - (location.x / frameSize.width));
        if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            NSError *error;
            
            if ([device lockForConfiguration:&error]) {
                [device setFocusPointOfInterest:pointOfInterest];
                
                [device setFocusMode:AVCaptureFocusModeAutoFocus];
                if([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
                    
                {
                    
                    [device setExposurePointOfInterest:pointOfInterest];
                    
                    [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
                    
                }
                [device unlockForConfiguration];
                NSLog(@"FOCUS OK");
            } else {
                
                NSLog(@"ERROR = %@", error);
            }  
        }  
    }  
}



- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{

    //为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // 锁定pixel buffer的基地址
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // 得到pixel buffer的基地址
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // 得到pixel buffer的行字节数
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // 得到pixel buffer的宽和高
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // 创建一个依赖于设备的RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // 根据这个位图context中的像素数据创建一个Quartz image对象
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // 解锁pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // 释放context和颜色空间
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // 用Quartz image创建一个UIImage对象image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // 释放Quartz image对象
    CGImageRelease(quartzImage);
    
    return (image);
}

// 获取视频第一帧
- (NSData*) getVideoPreViewImage:(NSURL *)path
{
    
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil] ;
    NSParameterAssert(asset);
    
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset] ;
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
        assetImageGenerator.maximumSize = CGSizeMake(800, 800);
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 1;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 2) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef){
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    }
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef]  : nil;
    CGImageRelease(thumbnailImageRef);
    
    CGFloat scale=1;
    CGSize imageSize = thumbnailImage.size;
    float width = imageSize.width;
    float height = imageSize.height;
    float targetWidth = width/scale;
    float targetHeight = targetWidth;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [thumbnailImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImageJPEGRepresentation(newImage,1.0);
    
    return data;
    
}

    
-(void)dealloc
{

    if (self.playerItem) {
        
        [LSNotificationCenter removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification  object:self.playerItem];
    }
    [LSNotificationCenter removeObserver:self];
    
}




@end
