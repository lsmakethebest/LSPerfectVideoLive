//
//  SpeechSynthesizer.m
//  AMapNaviKit
//
//  Created by 刘博 on 16/4/1.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

#import "SpeechSynthesizer.h"
#import <AVFoundation/AVFoundation.h>
@interface SpeechSynthesizer () <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong, readwrite) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation SpeechSynthesizer

+ (instancetype)sharedSpeechSynthesizer
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SpeechSynthesizer alloc] init];
        
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self buildSpeechSynthesizer];
    }
    return self;
}

- (void)buildSpeechSynthesizer
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        return;
    }
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.speechSynthesizer setDelegate:self];
}

- (void)speakString:(NSString *)string
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [session setActive:YES error:NULL];
    if (self.speechSynthesizer)
    {
        AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
        [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
        
        //iOS语音合成在iOS8及以下版本系统上语速异常
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
        {
            aUtterance.rate = 0.25;//iOS7设置为0.25
        }
        else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)
        {
            aUtterance.rate = 0.15;//iOS8设置为0.15
        }
        
        if ([self.speechSynthesizer isSpeaking])
        {
            [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        }
        
        [self.speechSynthesizer speakUtterance:aUtterance];
    }
}

- (void)stopSpeak
{
    if (self.speechSynthesizer)
    {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
     [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    
}

@end
