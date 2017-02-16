//
//  LSSettingCell.m
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSSettingCell.h"
#import "LSSettingItem.h"
#import "LSSettingLabelItem.h"
#import "LSSettingSwitchItem.h"
#import "LSSettingArrowItem.h"

@interface LSSettingCell ()
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UILabel *lableView;
@property (nonatomic, strong) UIImageView *arrView;
@end
@implementation LSSettingCell


+(instancetype)settingCellWithTableView:(UITableView*)tableView
{
    static NSString *identifier=@"cell";
    LSSettingCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[LSSettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
    }
    return cell;
    
}


//懒加载辅助view

-(UISwitch *)switchView
{
    if (_switchView==nil) {
        _switchView=[[UISwitch alloc]init];
        [_switchView addTarget:self action:@selector(clickValueChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchView;
}
-(UILabel *)lableView
{
    if (_lableView==nil) {
        _lableView=[[UILabel alloc]init];
    }
    return _lableView;
}
-(UIImageView *)arrView
{
    if (_arrView==nil) {
        _arrView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backarrow"]];
    }
    return _arrView;
}
-(void)setItem:(LSSettingItem *)item
{
    _item=item;
    self.textLabel.text=item.title;
    self.detailTextLabel.text=item.subTitle;
    if (item.subTitle.length>0&&item.subTitleColor) {
        self.detailTextLabel.textColor=item.subTitleColor;
    }
    if (item.icon) {
        
        self.imageView.image=[UIImage imageNamed:item.icon];
    }
   
  if ([item isKindOfClass:[LSSettingArrowItem class]]){
        self.accessoryView=self.arrView;
        self.selectionStyle=UITableViewCellSelectionStyleDefault;

        
    }
    else if ([item isKindOfClass:[LSSettingSwitchItem class]]){
        
        self.accessoryView=self.switchView;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.switchView.on=[[NSUserDefaults standardUserDefaults] boolForKey:self.item.title];

    }
    else if ([item isKindOfClass:[LSSettingLabelItem class]]){
        self.accessoryView=self.lableView;
        self.lableView.text=item.subTitle;
        self.selectionStyle=UITableViewCellSelectionStyleDefault;

        
    }
    else {
        self.accessoryView=nil;
        self.selectionStyle=UITableViewCellSelectionStyleDefault;
    }
  
}
-(void)clickValueChange:(UISwitch*)switchView
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:switchView.isOn forKey:self.item.title];
}
@end
