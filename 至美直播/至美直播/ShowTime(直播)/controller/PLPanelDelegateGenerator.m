//
//  PLPanelDelegateGenerator.m
//  PLCameraStreamingKitDemo
//
//  Created by TaoZeyu on 16/5/30.
//  Copyright © 2016年 Pili. All rights reserved.
//

#import "PLPanelDelegateGenerator.h"
#import "PLStreamingKitDemoUtils.h"
#import <BlocksKit/NSObject+A2DynamicDelegate.h>
#import <PLMediaStreamingKit/PLStreamingKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation PLPanelDelegateGenerator
{
    PLStreamingSession *_streamingSession;
}

- (instancetype)initWithMediaStreamingSession:(PLStreamingSession *)streamingSession
{
    if (self = [self init]) {
        _streamingSession = streamingSession;
    }
    return self;
}

- (void)generate
{
    __weak typeof(self) wSelf = self;
    
    NSDictionary *streamStateDictionary = @{@(PLStreamStateUnknow):             @"Unknow",
                                            @(PLStreamStateConnecting):         @"Connecting",
                                            @(PLStreamStateConnected):          @"Connected",
                                            @(PLStreamStateDisconnecting):      @"Disconnecting",
                                            @(PLStreamStateDisconnected):       @"Disconnected",
                                            @(PLStreamStateAutoReconnecting):   @"AutoReconnecting",
                                            @(PLStreamStateError):              @"Error",
                                            };
    NSDictionary *authorizationDictionary =@{@(PLAuthorizationStatusNotDetermined):    @"NotDetermined",
                                              @(PLAuthorizationStatusRestricted):       @"Restricted",
                                              @(PLAuthorizationStatusDenied):           @"Denied",
                                              @(PLAuthorizationStatusAuthorized):       @"Authorized",
                                              };
    [PLDelgateHelper bindTarget:_streamingSession property:@"delegate" block:^(A2DynamicDelegate *d) {
        
        [d implementMethod:@selector(mediaStreamingSession:streamStateDidChange:) withBlock:^(PLStreamingSession *session, PLStreamState state) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(wSelf) strongSelf = wSelf;
                NSLog(@"%@", [NSString stringWithFormat:@"session state changed%@", streamStateDictionary[@(state)]]);
                if ([strongSelf.delegate respondsToSelector:@selector(panelDelegateGenerator:streamStateDidChange:)]) {
                    [strongSelf.delegate panelDelegateGenerator:strongSelf streamStateDidChange:state];
                }
            });
        }];
        [d implementMethod:@selector(mediaStreamingSession:didDisconnectWithError:) withBlock:^(PLStreamingSession *session, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(wSelf) strongSelf = wSelf;
                NSLog(@"%@", [NSString stringWithFormat:@"session disconnected due to error %@", error]);
                if ([strongSelf.delegate respondsToSelector:@selector(panelDelegateGenerator:streamDidDisconnectWithError:)]) {
                    [strongSelf.delegate panelDelegateGenerator:strongSelf streamDidDisconnectWithError:error];
                }
            });
        }];
        [d implementMethod:@selector(mediaStreamingSession:streamStatusDidUpdate:) withBlock:^(PLStreamingSession *session, PLStreamStatus *status){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", [NSString stringWithFormat:@"session status %@", status]);
            });
        }];
        [d implementMethod:@selector(mediaStreamingSession:didGetCameraAuthorizationStatus:) withBlock:^(PLStreamingSession *session, PLAuthorizationStatus authorizationStatus){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", [NSString stringWithFormat:@"camera authorization status changed %@", authorizationDictionary[@(authorizationStatus)]]);
            });
        }];
        [d implementMethod:@selector(mediaStreamingSession:didGetMicrophoneAuthorizationStatus:) withBlock:^(PLStreamingSession *session, PLAuthorizationStatus authorizationStatus){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", [NSString stringWithFormat:@"microphone  authorization status changed %@", authorizationDictionary[@(authorizationStatus)]]);
            });
        }];
        [d implementMethod:@selector(mediaStreamingSession:cameraSourceDidGetPixelBuffer:) withBlock:^CVPixelBufferRef(PLStreamingSession *session, CVPixelBufferRef pixelBuffer) {
            __strong typeof(wSelf) strongSelf = wSelf;
            if (strongSelf.needProcessVideo) {
                size_t w = CVPixelBufferGetWidth(pixelBuffer);
                size_t h = CVPixelBufferGetHeight(pixelBuffer);
                size_t par = CVPixelBufferGetBytesPerRow(pixelBuffer);
                CVPixelBufferLockBaseAddress(pixelBuffer, 0);
                uint8_t *pimg = CVPixelBufferGetBaseAddress(pixelBuffer);
                for (int i = 0; i < w; i ++){
                    for (int j = 0; j < h; j++){
                        pimg[j * par + i * 4 + 1] = 255;
                    }
                }
                CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
            }
            return pixelBuffer;
        }];
    }];
}

@end
