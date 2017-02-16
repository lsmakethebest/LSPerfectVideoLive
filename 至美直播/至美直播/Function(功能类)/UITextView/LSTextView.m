
//
//  LSTextView.m
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSTextView.h"
@interface LSTextView()

@property (nonatomic, weak) UILabel * placeholderLabel ;
@end
@implementation LSTextView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}
-(void)setupViews
{
    UILabel *placeholderLabel=[[UILabel alloc]init];
    placeholderLabel.numberOfLines=0;
    placeholderLabel.textColor=[UIColor colorWithWhite:0.821 alpha:1.000];
    [self  addSubview:placeholderLabel];
    self.placeholderLabel=placeholderLabel;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    self.font=[UIFont systemFontOfSize:12];

}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder: aDecoder]) {
        [self setupViews];
    }
    return self;
}
//监听文本变化通知
-(void)textChange
{
    self.placeholderLabel.hidden=self.text.length!=0;

}
-(void)setText:(NSString *)text
{
    [super setText:text];
    self.placeholderLabel.hidden=self.text.length!=0;
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=placeholder;
    self.placeholderLabel.text=placeholder;
    
    [self setNeedsLayout];
    
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor=placeholderColor;
    self.placeholderLabel.textColor=placeholderColor;
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font=font;
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.x=6;
    self.placeholderLabel.y=8
    ;
    self.placeholderLabel.width=self.width-2*self.placeholderLabel.x;
    CGSize size= [self.placeholderLabel.text boundingRectWithSize:CGSizeMake(self.placeholderLabel.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil].size;
    self.placeholderLabel.height=size.height;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}
@end
