//
//  SelectedDatePickerView.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickClosure)(NSDate* date,NSString* dateString);
//IB_DESIGNABLE

@interface SelectedDatePickerView : UIView

+(void)showDatePickerViewWithformatString:(NSString *)formatString ClickClosure:(ClickClosure)clickClosure;

//回调block
@property (nonatomic,copy) ClickClosure clickClosure;

@end
