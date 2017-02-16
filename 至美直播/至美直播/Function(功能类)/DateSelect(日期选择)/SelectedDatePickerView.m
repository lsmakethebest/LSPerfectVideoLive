
//
//  SelectedDatePickerView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "SelectedDatePickerView.h"

@interface SelectedDatePickerView ()

@property (nonatomic,copy) NSString *formatString;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation SelectedDatePickerView


+(void)showDatePickerViewWithformatString:(NSString *)formatString ClickClosure:(ClickClosure)clickClosure
{
    
    SelectedDatePickerView *view = [[[NSBundle mainBundle]loadNibNamed:@"SelectedDatePickerView" owner:nil options:nil]lastObject];
    view.layer.cornerRadius=5;
    view.layer.masksToBounds=YES;
    view.formatString=formatString;
    if (formatString==nil) {
        view.formatString=@"yyyy-MM-dd";
    }
    view.datePicker.datePickerMode = UIDatePickerModeDate;
    view.clickClosure = clickClosure;
    
    UIView *window = [[[UIApplication sharedApplication] windows] lastObject];
    
    UIView *backView = [[UIView alloc] initWithFrame:window.bounds];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:view action:@selector(disMiss)]];
    backView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.204];
    view.center = backView.center;
    [backView addSubview:view];
    
    [window addSubview:backView];
    backView.alpha = 0;
    view.alpha=0;
    [UIView animateWithDuration:0.25
                     animations:^{
                         view.alpha=1;
                         backView.alpha = 1;
                     }];
}

#pragma mark - 确定按钮
- (IBAction)enterClick:(UIButton *)sender {
    
    NSDate *date = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en"];
    dateFormatter.dateFormat=self.formatString;
    NSString *dateString =  [dateFormatter stringFromDate:date];
    if (self.clickClosure) {
        self.clickClosure(date,dateString);
        [self disMiss];
    }
    
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self disMiss];
    
}
-(void)disMiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha=0;
        self.superview.alpha=0;
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}
#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
@end