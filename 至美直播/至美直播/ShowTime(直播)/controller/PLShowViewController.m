




//
//  PLShowViewController.m
//  至美直播
//
//  Created by 刘松 on 16/11/1.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "PLShowViewController.h"


#import "PLPanelDelegateGenerator.h"
#import <PLMediaStreamingKit/PLStreamingSession.h>

@interface PLShowViewController ()

{

    PLStreamingSession *_streamingSession;
    PLPanelDelegateGenerator *_panelDelegateGenerator;
    NSURL *_streamURL;
}


//@property(nonatomic,strong) PLCameraStreamingSession *session;
@end


@implementation PLShowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"streamKey"]=[LSUserTool sharedUserTool].userModel.uid;
    [HttpManager POSTWithURLString:LSCreateStreamURL parameters:params success:^(NSDictionary *response) {
        DLog(@"-----%@",response);
        
        _streamURL=[NSURL URLWithString:response[@"rtmpurl"]];
        [self pressedStart];
    } failure:^(NSError *error) {
       
    }];
    
    
    
    _panelDelegateGenerator = [[PLPanelDelegateGenerator alloc] initWithMediaStreamingSession:_streamingSession];
    [_panelDelegateGenerator generate];
    _panelDelegateGenerator.delegate = self;
    
    
    
    
}
- (void)pressedStart
{
    if (!_streamingSession.isRunning) {
        if (!_streamURL) {
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"还没有获取到 streamURL 不能推流哦" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil] show];
            return;
        }

        [_streamingSession startWithPushURL:_streamURL feedback:^(PLStreamStartStateFeedback feedback) {
            NSString *log = [NSString stringWithFormat:@"session start state %lu",(unsigned long)feedback];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", log);

                if ( feedback==PLStreamStartStateSuccess) {

                } else {
                    [[[UIAlertView alloc] initWithTitle:@"错误" message:@"推流失败了" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil] show];
                }
            });
   
        }] ;
        
    } else {
        [_streamingSession stop];

    }
}















@end
