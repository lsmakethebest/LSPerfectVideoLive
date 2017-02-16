





//
//  KCMapNavTool.m
//  driver
//
//  Created by 刘松 on 16/9/19.
//  Copyright © 2016年 driver. All rights reserved.
//

#import "KCMapNavTool.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#define kRoutePlanInfoViewHeight 30
//#import "MoreMenuView.h"

#define KCNavRouteFailure @"规划路线失败"
#define KCNavRouteMessage @"正在规划路线"

@interface KCMapNavTool ()<AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate>


@property (nonatomic, strong) AMapNaviDriveManager *driveManager;

@property (nonatomic, strong) AMapNaviDriveView *driveView;



@property(nonatomic,strong)AMapLocationManager  *locationManager;

@property (nonatomic, strong) AMapSearchAPI *search;

//@property (nonatomic, strong) MoreMenuView *moreMenu;
@property (nonatomic,assign) BOOL isSuccess;




@property (nonatomic,copy) NSString *searchText;

@property (nonatomic,assign) BOOL isChange;

@end

@implementation KCMapNavTool

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=RGB(0x242730);
    
    [self initDriveView];
    
    [self initDriveManager];
    
    //    [self initMoreMenu];
    
    //        self.startPoint   = [AMapNaviPoint locationWithLatitude:39.98486572 longitude:116.33362305];
    
    
    [self configLocationManager];
}

- (void)configLocationManager
{
    
    
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    [self requestLocation];
    
}
-(void)requestLocation
{
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            [UIToast showMessage:@"请检查是否授予位置权限"];
            return ;
        }
        if (location==nil) {
            [UIToast showMessage:@"请检查是否授予位置权限"];
            return ;
        }
        
        if (self.isSuccess) {
            return;
        }
        self.isSuccess=YES;
        DLog(@"请求请求请求请求请求请求请求请求请求-------------");
        DLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        DLog(@"location:%@", location);
        [self  showLoadingWithMessage:KCNavRouteMessage];
        self.startPoint= [AMapNaviPoint locationWithLatitude:location.coordinate.latitude   longitude:location.coordinate.longitude];
        
        if (self.searchText.length<=0) {
            [self calculateRoute];
            return;
        }
        
        AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
        geo.address =self.searchText;
        self.search=[[AMapSearchAPI alloc]init];
        self.search.delegate=self;
        self.search.timeout=5;
        [self.search AMapGeocodeSearch:geo];
        
        
        
    }];
    

    
}


- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{

    DLog(@"状态状态状态状态状态状态-------------%d",status);
    if (status==kCLAuthorizationStatusAuthorizedAlways||status==kCLAuthorizationStatusAuthorizedWhenInUse) {
        DLog(@"重新检测");
        [self requestLocation];
    }
    
    
    
}

- (void)viewWillLayoutSubviews
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
    {
        interfaceOrientation = self.interfaceOrientation;
    }
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        [self.driveView setIsLandscape:NO];
    }
    else if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        [self.driveView setIsLandscape:YES];
    }
}


- (void)initDriveManager
{
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        [self.driveManager setDelegate:self];
        
        //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
        [self.driveManager addDataRepresentative:self.driveView];
    }
}


- (void)initDriveView
{
    if (self.driveView == nil)
    {
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        
        //        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        self.driveView.height-=20;
        self.driveView.y=20;
        self.driveView.showTrafficLayer=NO;
        self.driveView.showCompass=YES;
        //        self.driveView.cameraDegree=60;
        self.driveView.showMoreButton=NO;
        [self.view addSubview:self.driveView];
    }
    
    
}


#pragma mark - Route Plan

- (void)calculateRoute
{
    //进行路径规划
    [self.driveManager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:nil
                                          drivingStrategy:AMapNaviDrivingStrategySingleDefault];
    //    [self.driveManager calculateDriveRouteWithEndPoints:@[self.endPoint] wayPoints:nil drivingStrategy:AMapNaviDrivingStrategySingleDefault];
}

#pragma mark - AMapSearchDelegate

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        [self hideLoading];
        [UIToast showMessage:KCNavRouteFailure];
        return;
    }
    
    AMapGeocode * geocode=response.geocodes.firstObject;
    self.endPoint=  [AMapNaviPoint locationWithLatitude: geocode.location.latitude longitude:geocode.location.longitude];
    [self calculateRoute];
    
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    [self hideLoading];
    [UIToast showMessage:@"请检查网络设置"];
}

-(void)dealloc
{
    
    
    //停止导航
    [self.driveManager stopNavi];
    [self.driveManager removeDataRepresentative:self.driveView];
    
    //停止语音
    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
    self.search.delegate=nil;
    self.driveManager=nil;
}
+(void)initWithModel:(KCConductOrderDetaileModel1 *)model isStart:(BOOL)isStart viewController:(UIViewController *)vc
{
    KCMapNavTool *tool=[[self alloc]init];
    //    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
    //
    //        //定位功能可用
    //
    //    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
    //
    //        //定位不能用
    //
    //    }
    if (isStart) {
        if (model.deliverMapLatitude.length>0) {
            tool.endPoint=[AMapNaviPoint locationWithLatitude:[model.deliverMapLatitude doubleValue] longitude:[model.deliverMapLongitude doubleValue]];
        }else{
            tool.searchText=StringFormat(model.deliverProvinceName, model.deliverCityName);
        }
    }else{
        if (model.takeMapLatitude.length>0) {
            tool.endPoint=[AMapNaviPoint locationWithLatitude:[model.takeMapLatitude doubleValue] longitude:[model.takeMapLongitude doubleValue]];
        }else{
            tool.searchText=StringFormat(model.takeProvinceName, model.takeCityName);
        }
    }
    if (tool.searchText.length>0) {
        
        [AlertTool showWithViewController:vc title:@"未获取到详细地址" message:@"只能导航到对应城市" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
            [vc presentViewController:tool animated:YES completion:nil];
        } cancle:nil];
        return;
    }
    
    [vc presentViewController:tool animated:YES completion:nil];
}
#pragma mark - AMapNaviDriveManager Delegate

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error
{
    DLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    DLog(@"onCalculateRouteSuccess算路成功");
    //算路成功后开始GPS导航
    [self  hideLoading];
    [self.driveManager startGPSNavi];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error
{
    [self  hideLoading];
    [UIToast showMessage:KCNavRouteFailure];
    DLog(@"onCalculateRouteFailure算路失败:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode
{
    DLog(@"didStartNavi开始导航");
}

- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager
{
    DLog(@"needRecalculateRouteForYaw重新计算路线");
    
}

- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager
{
    DLog(@"needRecalculateRouteForTrafficJam");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex
{
    DLog(@"onArrivedWayPoint:%d", wayPointIndex);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    DLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager
{
    DLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager
{
    DLog(@"onArrivedDestination到达目的地");
}

#pragma mark - AMapNaviWalkViewDelegate
#pragma mark - 结束导航
- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView
{
    
    [AlertTool showWithViewController:self title:@"提示" message:@"确定退出导航?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    } cancle:nil];
    
    
}

- (void)driveViewMoreButtonClicked:(AMapNaviDriveView *)driveView
{
    //配置MoreMenu状态
    //    [self.moreMenu setTrackingMode:self.driveView.trackingMode];
    //    [self.moreMenu setShowNightType:self.driveView.showStandardNightType];
    //
    //    [self.moreMenu setFrame:self.view.bounds];
    //    [self.view addSubview:self.moreMenu];
}

- (void)driveViewTrunIndicatorViewTapped:(AMapNaviDriveView *)driveView
{
    DLog(@"TrunIndicatorViewTapped");
}

- (void)driveView:(AMapNaviDriveView *)driveView didChangeShowMode:(AMapNaviDriveViewShowMode)showMode
{
    DLog(@"didChangeShowMode:%ld", (long)showMode);
}


@end
