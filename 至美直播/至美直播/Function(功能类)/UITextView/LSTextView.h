//
//  LSTextView.h
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSEmotion;
@interface LSTextView : UITextView
//占位符
@property (nonatomic, copy) NSString *placeholder;
//占位符颜色
@property (nonatomic, strong) UIColor *placeholderColor;
//监听文本变化通知
-(void)textChange;
@end
