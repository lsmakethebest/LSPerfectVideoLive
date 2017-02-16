//
//  LSCalendar.h
//  LSCalendar
//
//  Created by 刘松 on 16/5/11.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CalendarCallbackBlock)(NSDate *date,NSString *dateString);

@interface LSCalendar : UIView

+(void)showWithTitle:(NSString*)title formatString:(NSString*)formatString block:(CalendarCallbackBlock)block;
@end
