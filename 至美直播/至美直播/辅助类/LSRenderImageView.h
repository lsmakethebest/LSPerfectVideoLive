//
//  LSRenderImageView.h
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface LSRenderImageView : UIImageView

@property (nonatomic,assign) CGFloat corner;
@property(nonatomic,strong) UIColor *iBorderColor;

@end
