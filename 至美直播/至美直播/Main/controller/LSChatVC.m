









//
//  LSChatVC.m
//  至美直播
//
//  Created by 刘松 on 16/10/26.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSChatVC.h"

#import <RongIMLib/RongIMLib.h>



@interface LSChatVC ()<RCIMClientReceiveMessageDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *data;

@property (weak, nonatomic) IBOutlet UITextField *content;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation LSChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chatID=@"333333";
    [[RCIMClient sharedRCIMClient]setReceiveMessageDelegate:self object:nil];
    self.data=[NSMutableArray array];
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userid"]=[LSUserTool sharedUserTool].userModel.uid;
    params[@"username"]=[LSUserTool sharedUserTool].userModel.username;
    [HttpManager POSTWithURLString:LSGetToken parameters:params success:^(NSDictionary *response) {
        if ([response[@"code"] integerValue]==200) {
            [[RCIMClient sharedRCIMClient]connectWithToken:response[@"token"] success:^(NSString *userId) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    DLog(@"连接成功");
                    [UIToast showMessage:@"连接成功"];
                });
                
            } error:^(RCConnectErrorCode status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIToast showMessage:@"连接失败"];
                    DLog(@"22222");
                });
            } tokenIncorrect:^{
                DLog(@"33333");
            }];

        }
    } failure:^(NSError *error) {
        
    }];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    RCTextMessage *textMessage=self.data[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@""];
    
    cell.textLabel.text=StringFormatThree (textMessage.senderUserInfo.name, @"说：",textMessage.content);
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}



- (IBAction)send:(id)sender {
    [self sendMessageWithContent:self.content.text isAdd:YES];
    
    
}
-(void)sendMessageWithContent:(NSString*)content isAdd:(BOOL)isAdd
{
    // 构建消息的内容，这里以文本消息为例。
    RCTextMessage *testMessage = [RCTextMessage messageWithContent:content];
    RCUserInfo *user=[[RCUserInfo alloc]initWithUserId:[LSUserTool sharedUserTool].userModel.uid name:[LSUserTool sharedUserTool].userModel.username  portrait:[LSUserTool sharedUserTool].userModel.headicon];
    testMessage.senderUserInfo=user;
    
    [[RCIMClient sharedRCIMClient]sendMessage:ConversationType_CHATROOM targetId:self.chatID content:testMessage pushContent:nil pushData:nil success:^(long messageId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIToast showMessage:@"发送成功"];
            DLog(@"发送成功");
        });
    } error:^(RCErrorCode nErrorCode, long messageId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIToast showMessage:@"发送失败"];
            DLog(@"发送失败");
        });
    }];
    if (isAdd) {
        [self.data addObject:testMessage];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.data.count-1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    }

}

- (IBAction)cancel:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([message.content isMemberOfClass:[RCTextMessage class]]) {
            
            
            RCTextMessage *testMessage = (RCTextMessage *)message.content;
            [UIToast showMessage:StringFormat(@"收到新消息：", testMessage.content)];
            [self.data addObject:testMessage];
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.data.count-1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
        }
        
        NSLog(@"还剩余的未接收的消息数：%d", nLeft);
        
    });
    
}
- (IBAction)create:(id)sender {
    
    [[RCIMClient sharedRCIMClient] joinChatRoom:self.chatID messageCount:-1 success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIToast showMessage:@"创建聊天室成功"];
            DLog(@"创建聊天室成功");
            [self getCount];

        });
    } error:^(RCErrorCode status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIToast showMessage:@"创建聊天室失败"];
            DLog(@"创建聊天室失败");
        });
    }];
    
}

- (IBAction)join:(id)sender {
    
    [[RCIMClient sharedRCIMClient] joinChatRoom:self.chatID messageCount:-1 success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIToast showMessage:@"创建聊天室成功"];
            [self sendMessageWithContent:@"来了" isAdd:NO];
            DLog(@"创建聊天室成功");
            [self getCount];
            
        });
    } error:^(RCErrorCode status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIToast showMessage:@"创建聊天室失败"];
            DLog(@"创建聊天室失败");
        });
    }];

    
//    [[RCIMClient sharedRCIMClient] joinExistChatRoom:self.chatID messageCount:-1 success:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [self sendMessageWithContent:@"来了" isAdd:NO];
//            [self getCount];
//            DLog(@"加入聊天室成功");
//            [UIToast showMessage:@"加入聊天室成功"];
//        });
//    } error:^(RCErrorCode status) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//        [UIToast showMessage:@"加入聊天室失败"];
//        DLog(@"加入聊天室失败");
//        });
//    }];

    
}
- (IBAction)exitChat:(id)sender {
    [[RCIMClient sharedRCIMClient]quitChatRoom:self.chatID success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            DLog(@"退出聊天室成功");
            [UIToast showMessage:@"退出聊天室成功"];
        });
        
    } error:^(RCErrorCode status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            DLog(@"退出聊天室失败");
            [UIToast showMessage:@"退出聊天室失败"];
        });
    }];
}

-(void)getCount
{
    
    [[RCIMClient sharedRCIMClient] getChatRoomInfo:self.chatID count:0 order:RC_ChatRoom_Member_Desc success:^(RCChatRoomInfo *chatRoomInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            DLog(@"总人数为===%d",chatRoomInfo.totalMemberCount);
            [UIToast showMessage:StringFromInt(chatRoomInfo.totalMemberCount)];
        });
        
    } error:^(RCErrorCode status) {
        dispatch_async(dispatch_get_main_queue(), ^{
        [UIToast showMessage:@"获取信息失败"];
        });
    }];

    
}
- (IBAction)getUserCount:(id)sender {
    [self getCount];
}
    
    
-(void)dealloc
{
    [[RCIMClient sharedRCIMClient]quitChatRoom:self.chatID success:^{
            DLog(@"退出聊天室成功");
    } error:^(RCErrorCode status) {
       
    }];
}

@end
