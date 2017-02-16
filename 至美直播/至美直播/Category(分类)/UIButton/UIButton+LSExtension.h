//
//  UIButton+LSExtension.h
//  LSCountDown
//
//  Created by ls on 16/1/18.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LSCountDown)

//记录是否倒计时完成
@property (nonatomic,assign) BOOL ls_countDowning;

//倒计时按钮
-(void)ls_startCountWithTime:(NSInteger)time  subTitle:(NSString*)subTitle disabledColor:(UIColor*)disabledColor;





//防止高频率点击 间隔
@property (nonatomic,assign) CGFloat ls_acceptEventInterval;

//点击按钮时自动隐藏键盘
@property (nonatomic,assign) BOOL ls_autoHideKeyboard;


@end
