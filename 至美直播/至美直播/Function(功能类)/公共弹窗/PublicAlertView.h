//
//  PublicAlertView.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/4.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockIndex)(int index);
@interface PublicAlertView : UIView

@property (nonatomic,copy) BlockIndex clickBlock;

/**
 *
 *  @param blockImage 点击的记几个按钮
 */
+ (void)showPayAlertViewWithArray:(NSArray*)array block:(BlockIndex)clickBlock;
@end
