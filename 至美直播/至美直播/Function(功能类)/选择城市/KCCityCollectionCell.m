

//
//  KCCityCollectionCell.m
//  driver
//
//  Created by 刘松 on 16/8/1.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCCityCollectionCell.h"

@interface KCCityCollectionCell ()
@property(nonatomic, weak) UILabel *label;
@end
@implementation KCCityCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    UILabel *label = [[UILabel alloc] init];
    label.textColor = KCColor2;
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    self.backgroundColor = RGB(0xf5f5f5);
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = KCColor5;
    self.selectedBackgroundView = view;
    self.radius = 3;
    self.label = label;
  }
  return self;
}
- (void)layoutSubviews {
  [super layoutSubviews];
  self.label.frame = self.bounds;
}
- (void)setContent:(NSString *)content {
  _content = content;
  self.label.text = content;
  if (content.length > 6) {
    self.label.font = KCFont6;
  } else {
    self.label.font = KCFont4;
  }
}
@end
