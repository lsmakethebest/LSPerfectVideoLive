//
//  PLPanelDelegateGenerator.h
//  PLCameraStreamingKitDemo
//
//  Created by TaoZeyu on 16/5/30.
//  Copyright © 2016年 Pili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PLMediaStreamingKit/PLStreamingKit.h>

#import <PLMediaStreamingKit/PLCameraStreamingKit.h>

@class PLPanelDelegateGenerator;

@protocol PLPanelDelegateGeneratorDelegate <NSObject>

@optional

- (void)panelDelegateGenerator:(PLPanelDelegateGenerator *)panelDelegateGenerator streamDidDisconnectWithError:(NSError *)error;
- (void)panelDelegateGenerator:(PLPanelDelegateGenerator *)panelDelegateGenerator streamStateDidChange:(PLStreamState)state;


@end


@interface PLPanelDelegateGenerator : NSObject

@property (nonatomic, weak) id<PLPanelDelegateGeneratorDelegate> delegate;
@property (nonatomic, assign) BOOL needProcessVideo;

- (instancetype)initWithMediaStreamingSession:(PLStreamingSession *)streamingSession;
- (void)generate;

@end
