//



//  LSProductController.m
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSProductController.h"
//#import "LSCollectionViewCell.h"
//#import "LSProductItem.h"
#define ID  @"CollectionViewCell"
@interface LSProductController ()
@property (nonatomic, strong) NSArray *products;
@end

@implementation LSProductController
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.collectionView registerClass:[LSCollectionViewCell class] forCellWithReuseIdentifier:ID];
    UINib *nib=[UINib nibWithNibName:@"LSCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    self.collectionView.backgroundColor=[UIColor whiteColor];
}
-(instancetype)init
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];

    if (self=[super initWithCollectionViewLayout:layout]) {
        layout.itemSize=CGSizeMake(85 , 85);

        layout.sectionInset=UIEdgeInsetsMake(10, 7, 0, 7);
//        layout.headerReferenceSize=CGSizeMake(10, 100);
        layout.minimumInteritemSpacing=7;
        layout.minimumLineSpacing=10;
        
    }
    return self;
}
//-(NSArray *)products
//{
//    if (_products==nil) {
//        NSString *path=[[NSBundle mainBundle]pathForResource:@"products.json" ofType:nil];
//        NSData *data=[NSData dataWithContentsOfFile:path];
//        NSArray *arr =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSMutableArray *arrM=[NSMutableArray array];
//        for (NSDictionary *dict in arr) {
//            LSProductItem *item=[LSProductItem productItemWithDict:dict];
//            [arrM addObject:item];
//        }
//        _products=arrM;
//    }
//    return _products;
//}
//
-(NSInteger)numberOfSectionsInCollectionView:(nonnull UICollectionView *)collectionView
{
    return 0;
}
-(NSInteger )collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
    return self.products.count;
}
//-(UICollectionViewCell*)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    LSCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    LSProductItem *item=self.products[indexPath.item];
//    cell.productItem=item;
//    return cell;
//}
//-(void)collectionView:(nonnull UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    LSProductItem *product=self.products[indexPath.item];
//    
//    NSString *path=[NSString stringWithFormat:@"%@://%@",product.customUrl,product.tagId];
//    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:path]]) {
//        NSLog(@"能代开本地软件");
//    }
//    else{
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:product.url]];
//        
//        
//    }
//    
//    
//    NSLog(@"%@",product.title);
//}
@end
