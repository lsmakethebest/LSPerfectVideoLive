//
//  KCSelectCommonCity.h
//  driver
//
//  Created by 刘松 on 16/10/9.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^KCSelectCommonCityCompletedBankSelect)(int index,BOOL isSelect);
@interface KCSelectCommonCity : UIView

+(instancetype)showWithArray:(NSArray*)array index:(NSInteger)index  view :(UIView*)view frame:(CGRect)frame completedBankSelect:(KCSelectCommonCityCompletedBankSelect)completedBankSelect;

-(void)cancel;

@end
