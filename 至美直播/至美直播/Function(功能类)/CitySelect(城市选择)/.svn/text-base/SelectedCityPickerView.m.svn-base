

//
//  SelectedCityPickerView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "SelectedCityPickerView.h"

@interface SelectedCityPickerView () <UIPickerViewDelegate,
                                      UIPickerViewDataSource>

@property(weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(nonatomic, strong) NSArray *allCitys;

@end

@implementation SelectedCityPickerView

- (NSArray *)allCitys {
  if (!_allCitys) {
    NSDictionary *dict = [NSDictionary
        dictionaryWithContentsOfURL:[[NSBundle mainBundle]
                                        URLForResource:@"citys.plist"
                                         withExtension:nil]];
    _allCitys = [Province mj_objectArrayWithKeyValuesArray:dict[@"citys"]];
      
  }
  return _allCitys;
}
+ (void)showCityPickerViewWithClickClosure:(CityClickClosure)clickClosure
{

  SelectedCityPickerView *view =
      [[[NSBundle mainBundle] loadNibNamed:@"SelectedCityPickerView"
                                     owner:nil
                                   options:nil] lastObject];
  view.layer.cornerRadius = 5;
  view.layer.masksToBounds = YES;
      view.clickClosure = clickClosure;

  UIView *window = [[[UIApplication sharedApplication] windows] lastObject];

  UIView *backView = [[UIView alloc] initWithFrame:window.bounds];
  backView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.204];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:view action:@selector(dismiss)]];
  view.center = backView.center;
  [backView addSubview:view];

  [window addSubview:backView];
  backView.alpha = 0;
  view.alpha = 0;
  [UIView animateWithDuration:0.25
                   animations:^{
                     view.alpha = 1;
                     backView.alpha = 1;
                   }];
}
-(void)handleTapGesture:(UITapGestureRecognizer*)tap
{
    [self dismiss];
}
- (void)dismiss {
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.alpha = 0;
                         self.superview.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.superview removeFromSuperview];
                     }];
}
#pragma mark - 确定按钮
- (IBAction)enterClick:(UIButton *)sender {

  [self dismiss];
  if (self.clickClosure) {
      Province *province=self.allCitys[[self.pickerView selectedRowInComponent:0]];
      City *city=province.cityArrayList[[self.pickerView selectedRowInComponent:1]];
      Area *area=city.areas[[self.pickerView selectedRowInComponent:2]];
            self.clickClosure(province,city,area);
  }
}
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *name;
//    if (component == 0) {
//        Province *province = self.allCitys[row];
//        name= province.province;
//    } else if (component == 1) {
//        Province *province =
//        self.allCitys[[self.pickerView selectedRowInComponent:0]];
//        City *city = province.cityArrayList[row];
//  name= city.city;
//    } else {
//        Province *province =
//        self.allCitys[[self.pickerView selectedRowInComponent:0]];
//        City *city =
//        province.cityArrayList[[self.pickerView selectedRowInComponent:1]];
//        Area *area = city.areas[row];
//        name= area.area;
//    }
//    NSAttributedString  *attStr=[[NSAttributedString alloc]initWithString:name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
//
//    return attStr;
//
//}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label=(UILabel *)view;
    if (label==nil) {
        label=[[UILabel alloc]init];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:15];
    }
    NSString *name;
    if (component == 0) {
        Province *province = self.allCitys[row];
        name= province.province;
    } else if (component == 1) {
        Province *province =
        self.allCitys[[self.pickerView selectedRowInComponent:0]];
        City *city ;
        if (province.cityArrayList.count>row) {
             city=province.cityArrayList[row];
        }
        name= city.city;
    } else {
        Province *province =
        self.allCitys[[self.pickerView selectedRowInComponent:0]];
        City *city ;
        if (province.cityArrayList.count>[self.pickerView selectedRowInComponent:1]) {
            city=province.cityArrayList[[self.pickerView selectedRowInComponent:1]];
        }
        Area *area ;
        if (city.areas.count>row) {
            area= city.areas[row];
        }
        name= area.area;
    }
    label.text=name;
    
    return label;

}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger number=0;
  if (component == 0) {

    number= self.allCitys.count;
  } else if (component == 1) {
    Province *province =
        self.allCitys[[self.pickerView selectedRowInComponent:0]];
    number= province.cityArrayList.count;
  } else {
    Province *province =
        self.allCitys[[self.pickerView selectedRowInComponent:0]];
    City *city =
        province.cityArrayList[[self.pickerView selectedRowInComponent:1]];
      
    number= city.areas.count;
  }
    return number;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 3;
}
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    [self.pickerView reloadAllComponents];
  if (component == 0) {
//    [self.pickerView reloadComponent:1];
//    [self.pickerView reloadComponent:2];
    [self.pickerView selectRow:0 inComponent:1 animated:YES];
    [self.pickerView selectRow:0 inComponent:2 animated:YES];

  } else if (component == 1) {
//    [self.pickerView reloadComponent:2];
    [self.pickerView selectRow:0 inComponent:2 animated:YES];
  }

}
#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self dismiss];
}
-(void)dealloc
{
    
}
@end
