


//
//  LSRefreshGifHeader.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSRefreshGifHeader.h"

@implementation LSRefreshGifHeader

-(instancetype)init
{
    if (self=[super init]) {
        
        
        self.lastUpdatedTimeLabel.hidden=YES;
        self.stateLabel.hidden=YES;
        NSArray *images= @[[UIImage imageNamed:@"reflesh1_60x55_"],[UIImage imageNamed:@"reflesh2_60x55_"],[UIImage imageNamed:@"reflesh3_60x55_"]];
        [self setImages:@[[UIImage imageNamed:@"reflesh1_60x55_"]] forState:MJRefreshStateIdle];
        [self setImages:@[[UIImage imageNamed:@"reflesh1_60x55_"]] forState:MJRefreshStatePulling];
        [self setImages:images forState:MJRefreshStateRefreshing];
        
        
        
    }
    return self;
}

@end
