



//
//  LSShareController.m
//  彩票
//
//  Created by song on 15/9/15.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSShareController.h"
#import <MessageUI/MessageUI.h>
@interface LSShareController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@end

@implementation LSShareController

- (void)viewDidLoad {
    [super viewDidLoad];
//__weak typeof(self) selfVc = self;
    LSSettingArrowItem *item1=[[LSSettingArrowItem alloc]initWithTitle:@"微博分享" Icon:@"WeiboSina"];

LSSettingArrowItem *item2=[[LSSettingArrowItem alloc]initWithTitle:@"邮件分享" Icon:@"SmsShare"];
    item2.option=^{
        //邮件分享
        if ([MFMailComposeViewController canSendMail]) {
            
            MFMailComposeViewController *vc=[[MFMailComposeViewController alloc]init];
            [vc setSubject:@"sdfsdf"];
            vc.delegate=self;
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
    };
    LSSettingArrowItem *item3=[[LSSettingArrowItem alloc]initWithTitle:@"短信分享" Icon:@"MailShare"];
    item3.option=^{
        //短信分享
        if ([MFMessageComposeViewController canSendText]) {
            MFMessageComposeViewController *mainVc=[[MFMessageComposeViewController alloc]init];
            mainVc.delegate=self;
            mainVc.body=@"10086";
            [self presentViewController:mainVc animated:YES completion:^{
                
            }];
        }
        
    };
    LSSettingGroup *group=[[LSSettingGroup alloc]init];
    [group.items addObject:item1];
    [group.items addObject:item2];
     [group.items addObject:item3];
    [self.datas addObject:group];
  
    
}
-(void)messageComposeViewController:(nonnull MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSLog(@"messageComposeViewController");
}
-(void)mailComposeController:(nonnull MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error
{
    NSLog(@"mailComposeController");
}

@end
