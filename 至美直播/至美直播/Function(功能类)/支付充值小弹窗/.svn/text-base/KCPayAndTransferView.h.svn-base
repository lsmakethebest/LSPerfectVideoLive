//
//  KCPayAndTransferView.h
//  kuaichengwuliu
//
//  Created by 刘松 on 16/5/28.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockPriceAndPassword)(NSString *price,NSString *password);

typedef enum {
  KCPayAndTransferViewTypePay,
  KCPayAndTransferViewTypeTakeOut

} KCPayAndTransferViewType;
@interface KCPayAndTransferView : UIView
@property(nonatomic, copy) BlockPriceAndPassword clickBlock;

/**
 *
 *  @param blockImage 点击的记几个按钮
 */
+ (void)showPayAlertViewWithType:(KCPayAndTransferViewType)type placeholder:(NSString*)placeholder title:(NSString*)title block:(BlockPriceAndPassword)clickBlock;

@end
