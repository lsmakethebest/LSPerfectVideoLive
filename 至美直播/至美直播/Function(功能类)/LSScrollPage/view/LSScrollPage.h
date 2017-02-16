//
//  LSScrollPage.h
//  LSScrollPage
//
//  Created by 刘松 on 16/5/8.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSContentController.h"
#import "LSTitleScrollView.h"


@interface LSScrollPage : UIView

@property (nonatomic,weak) LSTitleScrollView *titleScrollView;

@property(nonatomic,strong) NSArray *models;
-(void)updateViewLocationWithIndex:(int)pageIndex;
@property (nonatomic,assign) Class contentClass;


@end
