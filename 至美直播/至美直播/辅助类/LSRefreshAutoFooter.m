
//
//  LSRefreshAutoFooter.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSRefreshAutoFooter.h"

@implementation LSRefreshAutoFooter
-(instancetype)init
{
    if (self=[super init]) {
        self.triggerAutomaticallyRefreshPercent=0.01;
//        self.stateLabel.hidden=YES;
    }
    return self;
}
@end
