//
//  DriveRoutePlanViewController.m
//  AMapNaviKit
//
//  Created by liubo on 7/29/16.
//  Copyright © 2016 AutoNavi. All rights reserved.
//

#import "DriveRoutePlanViewController.h"

#import "NaviPointAnnotation.h"
#import "SelectableOverlay.h"
#import "RouteCollectionViewCell.h"
#import "PreferenceView.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "KCMapNavTool.h"


#define kRoutePlanInfoViewHeight    130.f
#define kRouteIndicatorViewHeight   64.f
#define kCollectionCellIdentifier   @"kCollectionCellIdentifier"
@interface DriveRoutePlanViewController ()<MAMapViewDelegate, AMapNaviDriveManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) AMapNaviPoint *startPoint;
@property (nonatomic, strong) AMapNaviPoint *endPoint;

@property (nonatomic, strong) UICollectionView *routeIndicatorView;
@property (nonatomic, strong) NSMutableArray *routeIndicatorInfoArray;
@property (nonatomic,assign) BOOL isCaluate;

@property (nonatomic,assign) BOOL lastLocation;

@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

@property(nonatomic,strong)AMapLocationManager  *locationManager;

@end

@implementation DriveRoutePlanViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"路线规划";
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initProperties];
    
    [self setupViews];
    
    [self initDriveManager];
    
    [self configLocationManager];
    
}


#pragma mark - Initalization

- (void)initProperties
{
    //为了方便展示驾车多路径规划，选择了固定的起终点
    self.endPoint   = [AMapNaviPoint locationWithLatitude:39.908791 longitude:116.321257];
    
    self.routeIndicatorInfoArray = [NSMutableArray array];
}


- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if ( self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.05 animations:^{
            
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }
    
}
-(void)setupViews
{
    
    [self initMapView];
    
    
    UIButton *button=[[UIButton alloc]init];
    button.backgroundColor=RandomColor;
    [button setTitle:@"开始导航" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(startNav) forControlEvents:UIControlEventTouchUpInside];
    CGFloat y= MaxY(self.mapView)+20;
    button.frame=CGRectMake(100,y, 100, 40);
    [self.view addSubview:button];
    
    
}
-(void)startNav
{
    //停止导航
    [self.driveManager stopNavi];
    self.driveManager=nil;
    KCMapNavTool *vc=[[KCMapNavTool alloc]init];
    vc.startPoint= [AMapNaviPoint locationWithLatitude:self.mapView.userLocation.coordinate.latitude longitude:self.mapView.userLocation.coordinate.longitude];
    vc.endPoint=self.endPoint;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0,
                                                                   self.view.bounds.size.width,
                                                                   SCREEN_H-64-kRouteIndicatorViewHeight)];
        [self.mapView setDelegate:self];
        self.mapView .showsUserLocation=YES;
        self.mapView.showsScale=YES;
        [self.mapView setCompassImage:[UIImage imageNamed:@"compass"]];
        //        self.mapView.compassOrigin=CGPointMake(SCREEN_W-45-8, 10);
        self.mapView.userTrackingMode=MAUserTrackingModeFollowWithHeading;
        [self.view addSubview:self.mapView];
    }
}

- (void)initDriveManager
{
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        [self.driveManager setDelegate:self];
    }
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
    
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    
    
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            DLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed)
            {
                
                return;
            }
        }
        DLog(@"location:%@", location);
        self.startPoint=[AMapNaviPoint locationWithLatitude:location.coordinate.latitude  longitude:location.coordinate.longitude];;
        [self.driveManager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                    endPoints:@[self.endPoint]
                                                    wayPoints:nil
                                              drivingStrategy:AMapNaviDrivingStrategySingleDefault];
        [self initAnnotations];
        
        if (regeocode)
        {
            DLog(@"reGeocode:%@", regeocode);
        }
    }];
}

- (void)initAnnotations
{
    NaviPointAnnotation *beginAnnotation = [[NaviPointAnnotation alloc] init];
    [beginAnnotation setCoordinate:CLLocationCoordinate2DMake(self.startPoint.latitude, self.startPoint.longitude)];
    beginAnnotation.title = @"起始点";
    beginAnnotation.navPointType = NaviPointAnnotationStart;
    
    [self.mapView addAnnotation:beginAnnotation];
    
    NaviPointAnnotation *endAnnotation = [[NaviPointAnnotation alloc] init];
    [endAnnotation setCoordinate:CLLocationCoordinate2DMake(self.endPoint.latitude, self.endPoint.longitude)];
    endAnnotation.title = @"终点";
    endAnnotation.navPointType = NaviPointAnnotationEnd;
    
    [self.mapView addAnnotation:endAnnotation];
}

#pragma mark - Handle Navi Routes

- (void)showNaviRoutes
{
    if ([self.driveManager.naviRoutes count] <= 0)
    {
        return;
    }
    
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.routeIndicatorInfoArray removeAllObjects];
    
    //将路径显示到地图上
    for (NSNumber *aRouteID in [self.driveManager.naviRoutes allKeys])
    {
        AMapNaviRoute *aRoute = [[self.driveManager naviRoutes] objectForKey:aRouteID];
        int count = (int)[[aRoute routeCoordinates] count];
        
        //添加路径Polyline
        CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(count * sizeof(CLLocationCoordinate2D));
        for (int i = 0; i < count; i++)
        {
            AMapNaviPoint *coordinate = [[aRoute routeCoordinates] objectAtIndex:i];
            coords[i].latitude = [coordinate latitude];
            coords[i].longitude = [coordinate longitude];
        }
        
        
        //        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:count];
        MAMultiPolyline *polyline=[MAMultiPolyline polylineWithCoordinates:coords count:count drawStyleIndexes:@[@100,@200,@(count-1)]];
        //        SelectableOverlay *selectablePolyline = [[SelectableOverlay alloc] initWithOverlay:polyline];
        //        [selectablePolyline setRouteID:[aRouteID integerValue]];
        
        [self.mapView addOverlay:polyline];
        free(coords);
        
        //更新CollectonView的信息
        RouteCollectionViewInfo *info = [[RouteCollectionViewInfo alloc] init];
        info.routeID = [aRouteID integerValue];
        //        info.title = [NSString stringWithFormat:@"路径ID:%ld | 路径计算策略:%ld", (long)[aRouteID integerValue], (long)[self.preferenceView strategyWithIsMultiple:self.isMultipleRoutePlan]];
        //        info.subtitle = [NSString stringWithFormat:@"长度:%ld米 | 预估时间:%ld秒 | 分段数:%ld", (long)aRoute.routeLength, (long)aRoute.routeTime, (long)aRoute.routeSegments.count];
        //
        [self.routeIndicatorInfoArray addObject:info];
    }
    
    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
    [self.routeIndicatorView reloadData];
    
    [self selectNaviRouteWithID:[[self.routeIndicatorInfoArray firstObject] routeID]];
    
    self.mapView.zoomLevel=15;
    self.mapView.userTrackingMode=MAUserTrackingModeFollowWithHeading;
    self.mapView.centerCoordinate=self.mapView.userLocation.coordinate;
}

- (void)selectNaviRouteWithID:(NSInteger)routeID
{
    //在开始导航前进行路径选择
    if ([self.driveManager selectNaviRouteWithRouteID:routeID])
    {
        [self selecteOverlayWithRouteID:routeID];
    }
    else
    {
        NSLog(@"路径选择失败!");
    }
}

- (void)selecteOverlayWithRouteID:(NSInteger)routeID
{
    return;
    [self.mapView.overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL *stop)
     {
         if ([overlay isKindOfClass:[SelectableOverlay class]])
         {
             SelectableOverlay *selectableOverlay = overlay;
             
             /* 获取overlay对应的renderer. */
             MAPolylineRenderer * overlayRenderer = (MAPolylineRenderer *)[self.mapView rendererForOverlay:selectableOverlay];
             
             if (selectableOverlay.routeID == routeID)
             {
                 /* 设置选中状态. */
                 selectableOverlay.selected = YES;
                 
                 /* 修改renderer选中颜色. */
                 overlayRenderer.fillColor   = selectableOverlay.selectedColor;
                 overlayRenderer.strokeColor = selectableOverlay.selectedColor;
                 
                 /* 修改overlay覆盖的顺序. */
                 [self.mapView exchangeOverlayAtIndex:idx withOverlayAtIndex:self.mapView.overlays.count - 1];
             }
             else
             {
                 /* 设置选中状态. */
                 selectableOverlay.selected = NO;
                 
                 /* 修改renderer选中颜色. */
                 overlayRenderer.fillColor   = selectableOverlay.regularColor;
                 overlayRenderer.strokeColor = selectableOverlay.regularColor;
             }
             
             [overlayRenderer glRender];
         }
     }];
}

#pragma mark - SubViews
#pragma mark - 显示顶部选择view


#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition1"];
        
        self.userLocationAnnotationView = annotationView;
        
        return annotationView;
    }
    
    else if ([annotation isKindOfClass:[NaviPointAnnotation class]])
    {
        static NSString *annotationIdentifier = @"NaviPointAnnotationIdentifier";
        
        
        MAAnnotationView *pointAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (pointAnnotationView == nil)
        {
            pointAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                                  reuseIdentifier:annotationIdentifier];
        }
        if ([annotation.title isEqualToString:@"起始点"]) {
            pointAnnotationView.image=[UIImage imageNamed:@"startPoint"];
        }else{
            pointAnnotationView.image=[UIImage imageNamed:@"endPoint"];
        }
//        pointAnnotationView.animatesDrop   = NO;
        pointAnnotationView.canShowCallout = YES;
        pointAnnotationView.draggable      = NO;
        
        NaviPointAnnotation *navAnnotation = (NaviPointAnnotation *)annotation;
        
//        if (navAnnotation.navPointType == NaviPointAnnotationStart)
//        {
//            [pointAnnotationView setPinColor:MAPinAnnotationColorGreen];
//        }
//        else if (navAnnotation.navPointType == NaviPointAnnotationEnd)
//        {
//            [pointAnnotationView setPinColor:MAPinAnnotationColorRed];
//        }
        
        return pointAnnotationView;
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        //        SelectableOverlay * selectableOverlay = (SelectableOverlay *)overlay;
        //        id<MAOverlay> actualOverlay = selectableOverlay.overlay;
        
        //          MAPolyline *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        MAMultiTexturePolylineRenderer *polylineRenderer=[[MAMultiTexturePolylineRenderer alloc]initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth    = 18.f;
        //        int i =arc4random()%5;
        //        [polylineRenderer loadStrokeTextureImage:[UIImage imageNamed:[NSString stringWithFormat:@"arrowTexture%d",i]]];
        
        UIImage * bad = [UIImage imageNamed:@"custtexture_bad"];
        UIImage * slow = [UIImage imageNamed:@"custtexture_slow"];
        UIImage * green = [UIImage imageNamed:@"custtexture_green"];
        
        BOOL succ = [polylineRenderer loadStrokeTextureImages:@[bad, slow, green]];
        if (!succ)
        {
            NSLog(@"loading texture image fail.");
        }
        
        return polylineRenderer;
        //        MAMultiTexturePolylineRenderer *render=  [[MAMultiTexturePolylineRenderer alloc]initWithPolyline:actualOverlay];
        //        [render loadStrokeTextureImages: @[[UIImage imageNamed:@"arrowTexture2"], [UIImage imageNamed:@"arrowTexture3"], [UIImage imageNamed:@"arrowTexture4"]]];
        //
        //        render.lineWidth=10;
        //        return  render;
        //        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:actualOverlay];
        //
        //        polylineRenderer.lineWidth = 8.f;
        //        polylineRenderer.strokeColor = selectableOverlay.isSelected ? selectableOverlay.selectedColor : selectableOverlay.regularColor;
        //        return polylineRenderer;
    }
    
    return nil;
}

#pragma mark - AMapNaviDriveManager Delegate

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error
{
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    //算路成功后显示路径
    [self showNaviRoutes];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error
{
    NSLog(@"onCalculateRouteFailure:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode
{
    NSLog(@"didStartNavi");
}

- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"needRecalculateRouteForYaw");
}

- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"needRecalculateRouteForTrafficJam");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex
{
    NSLog(@"onArrivedWayPoint:%d", wayPointIndex);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onArrivedDestination");
}



-(void)dealloc
{
    
    
}
@end
