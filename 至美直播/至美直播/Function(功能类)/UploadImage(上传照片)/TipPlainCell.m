

//
//  UploadImageCell.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "TipPlainCell.h"

@interface TipPlainCell ()
@end

@implementation TipPlainCell
+(instancetype)tipPlainCellWithTableView:(UITableView *)tableView
{
    static NSString *reuseID=@"cell";
    TipPlainCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell==nil) {
        cell=[[TipPlainCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseID];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    return  cell;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame=self.contentView.bounds;
}
@end
