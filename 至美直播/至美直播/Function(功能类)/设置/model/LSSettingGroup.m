



//
//  LSSettingGroup.m
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSSettingGroup.h"

@implementation LSSettingGroup

-(NSMutableArray *)items
{
    if (_items==nil) {
        _items=[NSMutableArray array];
    }
    return _items;
}

@end
