

//
//  KCSelectCityView.m
//  driver
//
//  Created by 刘松 on 16/8/1.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCSelectCityView.h"

#import "KCCityCollectionCell.h"

@interface KCSelectCityView () <UICollectionViewDelegate,
                                UICollectionViewDataSource>

@property(nonatomic, weak) UIButton *backButton;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *nameLabel;

@property(nonatomic, weak) UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *allCitys;
@property(nonatomic, strong) Province *province;
@property(nonatomic, strong) City *city;

@property (nonatomic,weak) UIView *topView;
@property (nonatomic,weak) UIView *line;
@property(nonatomic, copy) KCSelectCityViewBlock block;
@property(nonatomic, copy) KCSelectCityViewBackBlock backBlock;
@end

@implementation KCSelectCityView

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

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setupViews];
  }
  return self;
}

- (void)setupViews {

  UIButton *back = [[UIButton alloc] init];
  [back addTarget:self
                action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
  [back setTitle:@"<返回" forState:UIControlStateNormal];
  back.titleLabel.font = KCFont1;
  [back setTitleColor:KCColor2 forState:UIControlStateNormal];
  [self addSubview:back];
  self.backButton = back;

  UILabel *titleLabel = [[UILabel alloc] init];

  titleLabel.text = @"已选择:";
  titleLabel.font = KCFont5;
  titleLabel.textColor = KCColor4;
  [self addSubview:titleLabel];
  self.titleLabel = titleLabel;

  UILabel *nameLabel = [[UILabel alloc] init];
  nameLabel.text = @"全国";
  nameLabel.textColor = KCColor2;
  nameLabel.font = KCFont3;
  [self addSubview:nameLabel];
  self.nameLabel = nameLabel;

  UICollectionViewFlowLayout *layout =
      [[UICollectionViewFlowLayout alloc] init];
  CGFloat width = (SCREEN_W - 2 * 12 - 2 * 8) / 3;
  layout.itemSize = CGSizeMake(width, 33);
  layout.minimumLineSpacing = 8;
  layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
  layout.minimumInteritemSpacing = 0;

  UICollectionView *collectionView =
      [[UICollectionView alloc] initWithFrame:CGRectZero
                         collectionViewLayout:layout];
  [collectionView registerClass:[KCCityCollectionCell class]
      forCellWithReuseIdentifier:@"cell"];
  collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView = collectionView;

  collectionView.delegate = self;
  collectionView.dataSource = self;
  [self addSubview:collectionView];
    
    UIView *topView=[[UIView alloc]init];
    topView.backgroundColor=KCBackGroundColor;
    [self addSubview:topView];
    self.topView=topView;
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=KCColorLine;
    [self addSubview:line];
    self.line=line;
    
    
}
- (void)settingFrame {
    self.topView.frame=CGRectMake(0, 0, self.width, 10);
    self.line.frame=CGRectMake(0, 10, self.width, 0.5);
    
    
  self.backgroundColor = [UIColor whiteColor];
  //    self.collectionView.backgroundColor=RandomColor;
  self.backButton.frame = CGRectMake(12, 8+10.5, 60, 40);
  self.titleLabel.center = self.center;
  self.titleLabel.x -= 40;
  self.titleLabel.y = self.backButton.y;
  self.titleLabel.width = 50;
  self.titleLabel.height = 40;

  CGFloat x = MaxX(self.titleLabel) + 10;
  self.nameLabel.frame = CGRectMake(x, 8+10.5, self.width - x - 10, 40);
  //  self.nameLabel.backgroundColor = RandomColor;
  //  self.titleLabel.backgroundColor = RandomColor;

  self.collectionView.frame = CGRectMake(0, 50+10.5, self.width, self.height - 50-10.5);
}
- (void)layoutSubviews {
  [super layoutSubviews];
}
+ (instancetype)showWithFrame:(CGRect)frame
                         view:(UIView *)view
                        block:(KCSelectCityViewBlock)block
                    backBlock:(KCSelectCityViewBackBlock)backBlock {
  KCSelectCityView *view1 = [[KCSelectCityView alloc] init];
  view1.block = block;
  view1.backBlock = backBlock;
  view1.frame = frame;
  [view addSubview:view1];
  [view1 settingFrame];
  //  view1.height = 0;
  //  [UIView animateWithDuration:0.3
  //                   animations:^{
  //                     view1.height = frame.size.height;
  //                   }];
  return view1;
}
- (NSInteger)numberOfSectionsInCollectionView:
    (UICollectionView *)collectionView {
  return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  if (self.province==nil) {
    return self.allCitys.count + 1;
  } else {
      return self.province.cityArrayList.count+1;
  }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  KCCityCollectionCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                forIndexPath:indexPath];
  if (self.province==nil) {
    if (indexPath.item == 0) {
      cell.content = @"全国";
    } else {
      Province *province = self.allCitys[indexPath.item - 1];
      cell.content = province.province;
    }
  } else {
    if (indexPath.item == 0) {
        cell.content = @"全省";
    } else {
        City *city = self.province.cityArrayList[indexPath.item - 1];
        cell.content = city.city;
    }
  }
  return cell;
}
- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item == 0) {
    if (self.province==nil) {
      if (self.block) {
        self.block(nil, nil);
      }
    } else {
      if (self.block) {

          self.block(self.province.provinceid   , self.province.province);
      }
    }
    [self cancel];
    return;
  }
  if (self.province==nil)
  {
      Province *province=self.allCitys[indexPath.item-1];
      if (province.cityArrayList.count==1)
      {
          if (self.block) {
              Province *province= self.allCitys[indexPath.item - 1];
              self.block(province.provinceid, province.province);
          }
          [self cancel];
      }else{
          self.province= self.allCitys[indexPath.item - 1];
          self.nameLabel.text=self.province.province;
          [collectionView reloadData];
      }
  }
  else
  {
      City *city = self.province.cityArrayList[indexPath.item - 1];
      if (self.block) {
          self.block(city.cityid, city.city);
      }
      [self cancel];
  }
}
- (void)back {
  if (self.province==nil) {
    if (self.backBlock) {
      self.backBlock();
    }
    [self cancel];
  }
  else {
    self.nameLabel.text = @"全国";
    self.province = nil;
    [self.collectionView reloadData];
  }
}
- (void)cancel {
  [self removeFromSuperview];
}
@end
