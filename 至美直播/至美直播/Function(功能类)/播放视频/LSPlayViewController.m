




//
//  LSPlayViewController.m
//  至美直播
//
//  Created by 刘松 on 2017/1/17.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


#import "LSPlayViewController.h"


@interface LSPlayViewController ()

@property (nonatomic,strong) AVPlayer *player;

@end

@implementation LSPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    NSString * pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.mp4"];
    NSString * pathToMovie = [[NSBundle mainBundle]pathForResource:@"Movie.mp4" ofType:nil];
    
    
    //    videoPath =  [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"instruction.mp4"];
    NSURL *url = [NSURL fileURLWithPath:pathToMovie];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    [self presentViewController:playerViewController animated:YES completion:nil];
    [playerViewController.player play];
    
    
    return;
    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:[self strUTF8Encoding:pathToMovie]]];
    //初始化player对象
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    if([[UIDevice currentDevice] systemVersion].intValue>=10){
        //      增加下面这行可以解决ios10兼容性问题了
        self.player.automaticallyWaitsToMinimizeStalling = NO;
    }
    //设置播放页面
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //设置播放页面的大小
    layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置播放窗口和当前视图之间的比例显示内容
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.view.layer addSublayer:layer];
    
}
#pragma mark - url 中文格式化
-(NSString *)strUTF8Encoding:(NSString *)str
{
    //ios9适配的话 打开第一个
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0){
        return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    }
    else{
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    
//    [self.player play];
    
    
}




@end
