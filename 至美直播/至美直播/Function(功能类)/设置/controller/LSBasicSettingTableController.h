//
//  LSBasicTableController.h
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSSettingItem.h"
#import "LSSettingGroup.h"
#import "LSSettingArrowItem.h"
#import "LSSettingSwitchItem.h"
#import "LSSettingLabelItem.h"


@interface LSBasicSettingTableController : UITableViewController

@property (nonatomic, strong) NSMutableArray *datas;

@end
