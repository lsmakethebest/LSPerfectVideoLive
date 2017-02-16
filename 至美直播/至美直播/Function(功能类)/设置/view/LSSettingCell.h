//
//  LSSettingCell.h
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSSettingItem.h"

@interface LSSettingCell : UITableViewCell

@property (nonatomic, strong) LSSettingItem *item;

+(instancetype)settingCellWithTableView:(UITableView*)tableView;

@end
