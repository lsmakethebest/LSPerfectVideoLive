//
//  LSLiveMaskView.h
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSUserModel.h"
@interface LSLiveMaskView : UIView

@property(nonatomic,strong) LSUserModel *model;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;


@end
