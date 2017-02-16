//
//  UploadImageView.m
//  kuaichengwuliu
//
//  Created by 刘松 on 16/4/30.
//  Copyright © 2016年 kuaicheng. All rights reserved.
//

#import "TipPlainCell.h"
#import "UploadImageView.h"
@interface UploadImageView () <
    UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,
    UIImagePickerControllerDelegate, UIGestureRecognizerDelegate,
    UIActionSheetDelegate>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSArray *contents;
@property(nonatomic, assign) int index;

@end
@implementation UploadImageView

+ (void)showUpUploadImageViewWithBlockImage:(BlockImage)blockImage {

  UploadImageView *v = [[UploadImageView alloc] init];
  [[UIApplication sharedApplication].keyWindow addSubview:v];
  v.clickBlockImage = blockImage;
  if (IOS_VERSION >= 8.0) {

    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:@"请选择"
                         message:nil
                  preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction
        actionWithTitle:@"相册"
                  style:(UIAlertActionStyleDefault)
                handler:^(UIAlertAction *_Nonnull action) {
                  UIImagePickerController *picker =
                      [[UIImagePickerController alloc] init];
                  picker.delegate = v;
                  picker.sourceType =
                      UIImagePickerControllerSourceTypePhotoLibrary;
                  [[UIApplication sharedApplication]
                          .keyWindow.rootViewController
                      presentViewController:picker
                                   animated:YES
                                 completion:nil];

                }];
    UIAlertAction *action2 = [UIAlertAction
        actionWithTitle:@"拍照"
                  style:(UIAlertActionStyleDefault)
                handler:^(UIAlertAction *_Nonnull action) {
                  UIImagePickerController *picker =
                      [[UIImagePickerController alloc] init];
                  picker.delegate = v;
                  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                  [[UIApplication sharedApplication]
                          .keyWindow.rootViewController
                      presentViewController:picker
                                   animated:YES
                                 completion:nil];
                }];
    UIAlertAction *action3 =
        [UIAlertAction actionWithTitle:@"取消"
                                 style:(UIAlertActionStyleCancel)
                               handler:^(UIAlertAction *_Nonnull action) {
                                 [v removeFromSuperview];

                               }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [[UIApplication sharedApplication]
            .keyWindow.rootViewController presentViewController:alert
                                                       animated:YES
                                                     completion:nil];
  } else {
    UIActionSheet *sheet =
        [[UIActionSheet alloc] initWithTitle:@"请选择"
                                    delegate:v
                           cancelButtonTitle:@"取消"
                      destructiveButtonTitle:nil
                           otherButtonTitles:@"相册", @"拍照", nil];
    [sheet showInView:[UIApplication sharedApplication]
                          .keyWindow.rootViewController.view];
  }
}

- (void)actionSheet:(UIActionSheet *)actionSheet
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;

  if (buttonIndex == 0) {
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [[UIApplication sharedApplication]
            .keyWindow.rootViewController presentViewController:picker
                                                       animated:YES
                                                     completion:nil];
  } else if (buttonIndex == 1) {

    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [[UIApplication sharedApplication]
            .keyWindow.rootViewController presentViewController:picker
                                                       animated:YES
                                                     completion:nil];
  } else if (buttonIndex == 2) {
    [self removeFromSuperview];
  }
}
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
  [picker dismissViewControllerAnimated:YES completion:nil];
  UIImage *image = info[UIImagePickerControllerOriginalImage];
  if (!image) {
    [self removeFromSuperview];
    return;
  }
  if (self.clickBlockImage) {
    self.clickBlockImage(image);
  }
  [self removeFromSuperview];
}

//+ (void)showUpUploadImageViewWithBlockImage:(BlockImage)blockImage
//{
//
//  UploadImageView *view = [[UploadImageView alloc] init];
//    view.clickBlockImage=blockImage;
//
//  UIView *window = [UIApplication sharedApplication] .keyWindow;
//
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]
//                                 initWithTarget:view
//                                 action:@selector(dismiss)];
//    tap.delegate=view;
//  [view addGestureRecognizer:tap];
//
//  view.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.204];
//  view.frame = window.bounds;
//    view.contents=@[@"拍照",@"从相册中选择"];
//  [window addSubview:view];
//
//  UITableView *tableView =
//      [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
//                                   style:UITableViewStylePlain];
//    tableView.layer.cornerRadius=5;
//    tableView.layer.masksToBounds=YES;
//  tableView.width = view.width * 3 / 5;
// tableView.height = view.contents.count * 44;
//  tableView.center = view.center;
//  tableView.delegate = view;
//  tableView.dataSource = view;
//  view.tableView = tableView;
//    [view addSubview:tableView];
//
//  view.alpha = 0;
//  tableView.alpha = 0;
//  [UIView animateWithDuration:0.25
//                   animations:^{
//                     view.alpha = 1;
//                     tableView.alpha = 1;
//                   }];
//}
//- (NSInteger)tableView:(UITableView *)tableView
// numberOfRowsInSection:(NSInteger)section {
//  return 2;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  TipPlainCell *cell =
//      [TipPlainCell tipPlainCellWithTableView:tableView];
//    cell.textLabel.text = self.contents[indexPath.row];
//  return cell;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath
//*)indexPath
//{
//    self.alpha=0;
//    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
//    picker.delegate=self;
//    if (indexPath.row==0) {
//        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
//    }else{
//    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//
//    [[UIApplication sharedApplication].keyWindow.rootViewController
//    presentViewController:picker animated:YES completion:nil];
//
//}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    [self removeFromSuperview];
//}
//-(void)dealloc
//{
//    NSLog(@"dealloc");
//
//
//}
///// 消失
//-(void)dismiss
//{
//    [UIView animateWithDuration:0.25 animations:^{
//        self.alpha = 0;
//
//    }completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        for (UIView *v in self.subviews) {
//            [v removeFromSuperview];
//        }
//
//    }];
//}
//#pragma mark -UIGestureRecognizerDelegate
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
//shouldReceiveTouch:(UITouch *)touch
//{
//    if ([NSStringFromClass([touch.view class])
//    isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return YES;
//}
@end
