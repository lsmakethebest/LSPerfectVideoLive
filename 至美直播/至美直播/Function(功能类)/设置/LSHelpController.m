


//
//  LSHelpController.m
//  彩票
//
//  Created by song on 15/9/14.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSHelpController.h"


@interface LSHelpController ()

@property (nonatomic, strong) NSArray *helps;
@end

@implementation LSHelpController

//-(NSArray *)helps
//{
//    if (_helps==nil) {
//        NSString *path=[[NSBundle mainBundle]pathForResource:@"help.json" ofType:nil];
//        NSData *data=[NSData dataWithContentsOfFile:path];
//        NSArray *arr= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
//        NSMutableArray *arrM=[NSMutableArray array];
//        for (NSDictionary *dict in arr) {
//            LSHelp *help=[LSHelp helpWithDict:dict];
//            [arrM addObject:help];
//        }
//        
//        _helps=arrM;
//    }
//    return _helps;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    NSMutableArray *items=[NSMutableArray array];
//    for (LSHelp *help in self.helps) {
//        LSSettingArrowItem *item=[[LSSettingArrowItem alloc]initWithTitle:help.title Icon:nil desClass:nil];
//        [items addObject:item];
//    }
//    LSSettingGroup *group=[[LSSettingGroup alloc]init];
//    group.items=items;
//    [self.datas addObject:group];
//    
//    
//}
//-(void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    LSWebViewController *vc=[[LSWebViewController alloc]init];
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
//    vc.help=self.helps[indexPath.row];
//    [self presentViewController:nav animated:YES completion:^{
//        
//    }];
//}


@end
