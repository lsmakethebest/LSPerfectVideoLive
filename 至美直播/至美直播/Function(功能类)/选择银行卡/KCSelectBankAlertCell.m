
//
//  KCSelectBankAlertCell.m
//  driver
//
//  Created by 刘松 on 16/7/8.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCSelectBankAlertCell.h"

@interface KCSelectBankAlertCell ()

@property (weak, nonatomic) IBOutlet UILabel *bankLabel;

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@end

@implementation KCSelectBankAlertCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(KCSelectBankModel *)model
{
    _model=model;
    
    self.bankLabel.text=model.bank;
    self.selectImageView.hidden=!model.selected;
}
@end
