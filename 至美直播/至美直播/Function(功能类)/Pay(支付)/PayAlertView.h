//
//  PayAlertView.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BlockIndex)(int index);
@interface PayAlertView : UIView


@property (nonatomic,copy) BlockIndex clickBlock;

/**
 *
 *  @param blockImage 点击的记几个按钮
 */
+(void)showPayAlertViewWithBlock:(BlockIndex)clickBlock;

@end
