

//
//  LSLiveMaskBottomView.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSLiveMaskBottomView.h"

@interface LSLiveMaskBottomView ()<XXNibBridge>




@end
@implementation LSLiveMaskBottomView

- (IBAction)clickBottom:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LSClickBottomButtonNotification object:@(sender.tag)];

}





@end
