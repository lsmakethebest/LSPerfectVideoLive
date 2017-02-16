//
//  LSProgressButton.h
//  至美直播
//
//  Created by 刘松 on 2017/1/16.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LSProgressButtonBlockTypeStart=0,
    LSProgressButtonBlockTypeEnd,
    LSProgressButtonBlockTypeCancel
    
}LSProgressButtonBlockType;


typedef void(^LSProgressButtonBlock)(LSProgressButtonBlockType type);


@interface LSProgressButton : UIView


+(void)showToView:(UIView *)view frame:(CGRect)frame success:(LSProgressButtonBlock)block;

@end
