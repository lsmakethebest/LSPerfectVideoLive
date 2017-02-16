

//
//  LSLiveMaskView.m
//  至美直播
//
//  Created by 刘松 on 16/8/6.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSLiveMaskView.h"
#import "LSLiveMaskTopView.h"
#import "LSLiveMaskBottomView.h"
#import <RongIMLib/RongIMLib.h>

@interface LSLiveMaskView ()<XXNibBridge,UITableViewDataSource,RCIMClientReceiveMessageDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet LSLiveMaskTopView *topView;

@property (weak, nonatomic) IBOutlet LSLiveMaskBottomView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property(nonatomic,strong) NSMutableArray *data;


@property (nonatomic,copy) NSString *chatID;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

static CGFloat PI = M_PI;

@implementation LSLiveMaskView


-(void)setModel:(LSUserModel *)model
{
    _model=model;
    self.topView.model=model;
    [self initConnect];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self send:nil];
    return YES;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(handle)];
    [self addGestureRecognizer:tap];
    
    [LSNotificationCenter addObserver:self selector:@selector(handleNofication:) name:LSClickBottomButtonNotification object:nil];
    [self.sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    
    [LSNotificationCenter addObserver:self selector:@selector(willShowKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [LSNotificationCenter addObserver:self selector:@selector(willHideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=44;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)willShowKeyBoard:(NSNotification*)note
{
    DLog(@"%@",note.userInfo);
 CGFloat height= [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.heightConstraint.constant=height;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)willHideKeyBoard:(NSNotification*)note
{
    CGRect frame=self.commentView.frame;
    frame.origin.y=-frame.size.height;
    self.heightConstraint.constant=-48;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
}
-(void)handleNofication:(NSNotification*)note
{
    
    int i=[note.object integerValue];
    
    if (i==1) {
        [self.textField becomeFirstResponder];
    }
    
}
-(void)handle
{
    [self animateInView:self];
}
- (void)animateInView:(UIView *)view
{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(SCREEN_W-20-20, SCREEN_H-80, 20, 20);
    int nameI = arc4random() % 4 + 1;
    imageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", nameI]];
    [view addSubview:imageView];
    
    
    NSTimeInterval totalAnimationDuration = 6;
    CGFloat heartSize = CGRectGetWidth(imageView.bounds);
    CGFloat heartCenterX = imageView.center.x;
    CGFloat viewHeight = CGRectGetHeight(view.bounds)/2;
    
    
    
    
    //Pre-Animation setup
    imageView.transform = CGAffineTransformMakeScale(0, 0);
    imageView.alpha = 0;
    
    //Bloom
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
        imageView.alpha = 0.9;
    } completion:NULL];
    
    NSInteger i = arc4random_uniform(2);
    NSInteger rotationDirection = 1- (2*i);// -1 OR 1
    NSInteger rotationFraction = arc4random_uniform(10);
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        imageView.transform = CGAffineTransformMakeRotation(rotationDirection * PI/(16 + rotationFraction*0.2));
    } completion:NULL];
    
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:imageView.center];
    
    //random end point
    CGPoint endPoint = CGPointMake(heartCenterX + (rotationDirection) * arc4random_uniform(2*heartSize), viewHeight/6.0 + arc4random_uniform(viewHeight/4.0));
    
    //random Control Points
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1- (2*j);// -1 OR 1
    
    //randomize x and y for control points
    CGFloat xDelta = (heartSize/2.0 + arc4random_uniform(2*heartSize)) * travelDirection;
    CGFloat yDelta = MAX(endPoint.y ,MAX(arc4random_uniform(8*heartSize), heartSize));
    CGPoint controlPoint1 = CGPointMake(heartCenterX + xDelta, viewHeight - yDelta);
    CGPoint controlPoint2 = CGPointMake(heartCenterX - 2*xDelta, yDelta);
    
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyFrameAnimation.duration = totalAnimationDuration + endPoint.y/viewHeight;
    [imageView.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    //Alpha & remove from superview
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}


- (void)initConnect {

    self.chatID=self.model.userId;
    [[RCIMClient sharedRCIMClient]setReceiveMessageDelegate:self object:nil];
    self.data=[NSMutableArray array];
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userid"]=[LSUserTool sharedUserTool].userModel.uid;
    params[@"username"]=[LSUserTool sharedUserTool].userModel.username;
    [LSHttpManager POST:LSGetToken parameters:params success:^(NSDictionary *response) {
        if ([response[@"code"] integerValue]==200) {
            [[RCIMClient sharedRCIMClient]connectWithToken:response[@"token"] success:^(NSString *userId) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    DLog(@"连接成功");
                    [UIToast showMessage:@"连接成功"];
                    [self create:nil];
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
        cell.textLabel.numberOfLines=0;
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
//        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.backgroundColor=[UIColor clearColor];
    }
    RCTextMessage *textMessage=self.data[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@""];
    
    cell.textLabel.text=StringFormatThree (textMessage.senderUserInfo.name, @"说：",textMessage.content);
    
    return cell;
}

- (IBAction)send:(id)sender {
    [self.textField resignFirstResponder];
    [self sendMessageWithContent:self.textField.text isAdd:YES];

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
            self.textField.text=@"";
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
            [UIToast showMessage:[NSString stringWithFormat: @"总人数为：%d",chatRoomInfo.totalMemberCount]];
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
    [LSNotificationCenter removeObserver:self];
    [[RCIMClient sharedRCIMClient]quitChatRoom:self.chatID success:^{
        DLog(@"退出聊天室成功");
    } error:^(RCErrorCode status) {
        
    }];
}




@end
