
//
//  KCPayAndTransferView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/28.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "KCPayAndTransferView.h"


@interface KCPayAndTransferView ()

@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UITextField *money;
@property (nonatomic,weak) UITextField *password;
@property (nonatomic,weak) UIButton *cancel;
@property (nonatomic,weak) UIButton *sure;
@property (nonatomic,assign) KCPayAndTransferViewType type;
@property (nonatomic,weak) UIView *alerView;

@end



@implementation KCPayAndTransferView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];

    }
    return self;
}

-(void)setupViews
{
    [LSNotificationCenter addObserver:self selector:@selector(show:) name:UIKeyboardWillShowNotification object:nil];
    [LSNotificationCenter addObserver:self selector:@selector(hide:) name:UIKeyboardWillHideNotification object:nil];
    self.backgroundColor=[UIColor colorWithWhite:0.321 alpha:0.393];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(hide)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap];

    UIView *alert=[[UIView alloc]init];
    alert.backgroundColor=[UIColor whiteColor];
    alert.layer.cornerRadius=5;
    alert.clipsToBounds=YES;
    [self addSubview:alert];
    self.alerView=alert;


    
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.textColor=KCColor7;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [alert addSubview:titleLabel];
    self.titleLabel=titleLabel;
    
    UITextField *money=[[UITextField alloc]init];
    money.placeholder=@"请输入支付金额";
    money.keyboardType=UIKeyboardTypeNumberPad;
    money.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home"]];
    money.leftViewMode=UITextFieldViewModeAlways;
    money.layer.borderColor=KCColor7.CGColor;
    money.layer.borderWidth=1;
    money.layer.cornerRadius=5;
    money.clipsToBounds=YES;
    [alert addSubview:money];
    self.money=money;
    
    UITextField *password=[[UITextField alloc]init];
    password.secureTextEntry=YES;
    password.layer.borderColor=KCColor7.CGColor;
    password.layer.borderWidth=1;
    password.layer.cornerRadius=5;
    password.clipsToBounds=YES;
    password.placeholder=@"请输入支付密码";
    password.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home"]];
    password.leftViewMode=UITextFieldViewModeAlways;
    [alert addSubview:password];
    self.password=password;
    
    UIButton *cancel=[[UIButton alloc]init];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:KCColor7 forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    cancel.layer.cornerRadius=3;
    cancel.clipsToBounds=YES;
    cancel.layer.borderWidth=1;
    cancel.layer.borderColor=KCColor7.CGColor;
    [alert addSubview:cancel];
    self.cancel=cancel;
    
    
    
    UIButton *sure=[[UIButton alloc]init];
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setTitleColor:KCColor7 forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    sure.layer.cornerRadius=3;
    sure.clipsToBounds=YES;
    sure.layer.borderWidth=1;
    sure.layer.borderColor=KCColor7.CGColor;
    [alert addSubview:sure];
    self.sure=sure;
    
    
}
+ (void)showPayAlertViewWithType:(KCPayAndTransferViewType)type  placeholder:(NSString *)placeholder title:(NSString *)title block:(BlockPriceAndPassword)clickBlock
{
    KCPayAndTransferView *view=[[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.clickBlock=clickBlock;
    view.type=type;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [self settingFrame:view];
    view.type=type;
    view.titleLabel.text=title;
    view.alpha = 0;
    view.money.placeholder=placeholder;
    view.alerView.alpha = 0;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         view.alpha = 1;
                         view.alerView.alpha = 1;
                         [view.money becomeFirstResponder];
                     }];

    
}
+(void)settingFrame:(KCPayAndTransferView*)view
{
    CGFloat labelHeight=40;
    CGFloat leftMargin=20;
    CGFloat fieldHeight=40;
    CGFloat buttonHeight=40;
    CGFloat margin=20;
    CGFloat bottomMargin=20;
    CGFloat height;
    CGFloat width=(SCREEN_H-leftMargin)/2;
    if (view.type==KCPayAndTransferViewTypePay) {
        height=labelHeight+fieldHeight+margin+buttonHeight+bottomMargin;
    }else{
        height=labelHeight+fieldHeight*2+3+margin+buttonHeight+bottomMargin;
    }
    view.alerView.frame=CGRectMake(leftMargin, (SCREEN_H- height)/2,width, height);
    
    view.titleLabel.frame=CGRectMake(0, 0, width, 40);
    view.money.frame=CGRectMake(10, labelHeight,width-2*10, fieldHeight);
    if (view.type==KCPayAndTransferViewTypePay) {
        view.password.frame=CGRectZero;
    }else{
        view.password.frame=CGRectMake(10, MaxY(view.money)+3, view.money.width, fieldHeight);
    }
    view.cancel.frame=CGRectMake(20, height-bottomMargin-buttonHeight, (width-3*20)/2, buttonHeight);
    view.sure.frame=CGRectMake(MaxX(view.cancel)+20, height-bottomMargin-buttonHeight, (width-3*20)/2, buttonHeight);
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat labelHeight=40;
//    CGFloat leftMargin=20;
//    CGFloat fieldHeight=40;
//    CGFloat buttonHeight=40;
//    CGFloat margin=20;
//    CGFloat bottomMargin=20;
//    CGFloat height;
//    CGFloat width=(SCREEN_H-leftMargin)/2;
//    if (self.type==KCPayAndTransferViewTypePay) {
//        height=labelHeight+fieldHeight+margin+buttonHeight+bottomMargin;
//    }else{
//        height=labelHeight+fieldHeight*2+3+margin+buttonHeight+bottomMargin;
//    }
//    self.alerView.frame=CGRectMake(15, (SCREEN_H- height)/2,width, height);
//    
//    self.titleLabel.frame=CGRectMake(0, 0, width, 40);
//    self.money.frame=CGRectMake(10, labelHeight,width-2*10, fieldHeight);
//    if (self.type==KCPayAndTransferViewTypePay) {
//        self.password.frame=CGRectZero;
//    }else{
//    self.password.frame=CGRectMake(10, MaxY(self.money)+3, self.money.width, fieldHeight);
//    }
//    self.cancel.frame=CGRectMake(20, height-bottomMargin-buttonHeight, (width-3*20)/2, buttonHeight);
//    self.sure.frame=CGRectMake(MaxX(self.cancel)+20, height-bottomMargin-buttonHeight, (width-3*20)/2, buttonHeight);

}

/// 消失
-(void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        
    }];
}
-(void)hide
{
    [self endEditing:YES];
}
-(void)sureClick
{
    if (self.clickBlock) {
        if (self.type==KCPayAndTransferViewTypePay) {
            if ([self.money.text isEqualToString:@""]) {
                [MBProgressHUD showError:self.money.placeholder];
                return;
            }
        }else{
        
            if ([self.money.text isEqualToString:@""]) {
                [MBProgressHUD showError:self.money.placeholder];
                return;
            }
            if ([self.password.text isEqualToString:@""]) {
                [MBProgressHUD showError:@"请输入支付密码"];
                return;
            }
            
        }
        self.clickBlock(self.money.text,self.password.text);
        [self dismiss];
    }
}
-(void)show:(NSNotification*)note
{

   CGFloat y = [note.userInfo[UIKeyboardFrameEndUserInfoKey]  CGRectValue].origin.y;
    CGFloat height=SCREEN_H-y;
    if (self.alerView.y<height) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alerView.y=SCREEN_H-height-self.alerView.height-10;
            
        }];
    }
}
-(void)hide:(NSNotification*)note
{
    self.alerView.y=(SCREEN_H-self.alerView.height)/2;    
}
-(void)dealloc
{
    [LSNotificationCenter removeObserver:self];
}
@end
