//
//  MapManager.m
//  ydx_bPassenger
//
//  Created by maoziyue on 2018/5/15.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import "MapManager.h"
//#import "YDXAlertView.h"

#define kAREADISTANCE  (800)





@interface MapManager ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapReGeocodeSearchRequest *reGeocodeSearchRequest;

@property (nonatomic, weak  ) MAAnnotationView *userLocationAnnotationView;

@property (nonatomic, assign) BOOL ishasUserLocation;


@end

@implementation MapManager
+ (instancetype)shareManager
{
    static MapManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[MapManager alloc] init];
        }
    });
    return _instance;
}

- (instancetype) init {
    
    if (self = [super init]) {
        [self inital];
    }
    return self;
}

- (void)inital {
    
}

- (void)dealloc {
    
}











- (void)setConfiguration
{
    [AMapServices sharedServices].apiKey = @"3c318641ead29745039083255176a9dc";
    
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.locatingWithReGeocode = YES;
    self.locationManager.distanceFilter = 0;
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    //开始定位
    [self.locationManager startUpdatingLocation];
}



- (void)locateMapViewInView:(UIView *)supView frame:(CGRect)frame
{
    [self initSearch];

    if (_mapView == nil) {
        _mapView = [[MAMapView alloc]initWithFrame:frame];
        _mapView.delegate = self;
        _mapView.showsScale = NO;
        _mapView.showsCompass = NO;
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = MAUserTrackingModeNone;
        _mapView.showsUserLocation = YES;
        _mapView.desiredAccuracy = kCLLocationAccuracyBest;
        _mapView.distanceFilter = 5.0f;
        _mapView.zoomLevel = 16.f;
        
       
    }
    
    [supView addSubview:_mapView];
    [supView sendSubviewToBack:_mapView];
    
    _mapView.logoCenter = CGPointMake(100, kStatusHeight);
}

- (void)initSearch
{
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
}





- (void)removeMapView
{
    if (_mapView) {
        [_mapView removeFromSuperview];
        _mapView = nil;
        _mapView.delegate = nil;
    }
}

- (void)mapInitComplete:(MAMapView *)mapView
{
   
}














//---------------------------------------------------------------------------
//MARK- method
//---------------------------------------------------------------------------
//回到当前定位点
- (void)startUserLocation
{
    
//    UIView *view= [[UIView alloc] initWithFrame:CGRectMake( kScreenW / 2 + kSIGN_WIDTH / 2 - (25 + 24/2), kScreenH / 2 + kSIGN_HEIGHT / 2, 5, 5)];
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
//    view.backgroundColor = [UIColor redColor];
    
    
    CLLocationCoordinate2D coordinate = self.mapView.userLocation.coordinate;
    

//    CGFloat setX = kScreenW / 2 + 217 / 2 - (25 + 24/2);
//    CGFloat setY = kScreenH / 2 + 88 / 2;
//    CGPoint pointt = CGPointMake(setX, setY);
//    CLLocationCoordinate2D randomCoordinate = [self.mapView convertPoint:pointt toCoordinateFromView: self.mapView.superview];
//    NSLog(@"---coordinate:(%.6f,%.6f)-----------",coordinate.latitude,coordinate.longitude);
//    NSLog(@"---randomCoor:(%.6f,%.6f)-----------",randomCoordinate.latitude,randomCoordinate.longitude);
//    NSLog(@"----------差值:(%.6f,%.6f)-----------",( randomCoordinate.latitude - coordinate.latitude),(randomCoordinate.longitude - coordinate.longitude));
  
 
    if (coordinate.latitude <= 0 || coordinate.longitude <= 0) {
        
        // 没位置, 显示上海
        coordinate = CLLocationCoordinate2DMake(31.230378, 121.473658);
        
        [self setReginCoordinate:coordinate animated:YES];
        
        [self.mapView setCenterCoordinate:coordinate animated:YES];
        
        //self.mapView.zoomLevel = 2;
        
        if ([self.delegate respondsToSelector:@selector(ydx_mapSearchRequest:didFailWithError:)]) {
            [self.delegate ydx_mapSearchRequest:[[AMapReGeocodeSearchRequest alloc] init] didFailWithError:nil];
        }
        return;
    }
    
    CLLocationCoordinate2D regincoordinate = CLLocationCoordinate2DMake(coordinate.latitude - (-0.000829), coordinate.longitude - 0.001575);
    [self setReginCoordinate:regincoordinate animated:YES];
    //[self.mapView setCenterCoordinate:coordinate animated:YES];
    self.mapView.showsUserLocation = YES;
    [self searchReGeocodeWithCoordinate:coordinate];
}
//逆地理搜索
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude
                                                                 longitude:coordinate.longitude];
    
    regeo.requireExtension            = YES;
    self.reGeocodeSearchRequest = regeo;
    [self.search AMapReGoecodeSearch:regeo];
}

//显示地图中心区域
- (void)setReginCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated
{
    MACoordinateRegion reg = MACoordinateRegionMakeWithDistance(coordinate, kAREADISTANCE, kAREADISTANCE);
    [self.mapView setRegion:reg animated:animated];
}






































#pragma mark --------------------------- 两个神奇的方法 -------------------------------------
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        static NSString *userLocationIdentifier = @"userLocationIdentifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationIdentifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationIdentifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable = NO;
            //annotationView.animatesDrop = NO;
        }
        annotationView.image = [UIImage imageNamed:@"now_adr"];
        self.userLocationAnnotationView = annotationView;
        return annotationView;
    }
    
    if ([self.delegate respondsToSelector:@selector(ydx_mapView:viewForAnnotation:)]) {
        return [self.delegate ydx_mapView:mapView viewForAnnotation:annotation];
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:(MACircle *)overlay];
        accuracyCircleRenderer.lineWidth    = 0.f;
        accuracyCircleRenderer.strokeColor  = [UIColor clearColor];
        accuracyCircleRenderer.fillColor    = [UIColor clearColor];
        return accuracyCircleRenderer;
    }
    else if ([self.delegate respondsToSelector:@selector(ydx_mapView:rendererForOverlay:)]) {
        return [self.delegate ydx_mapView:mapView rendererForOverlay:overlay];
    }
    


    return nil;
}

















#pragma mark --------------------------- mapViewDelegate -------------------------------------

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{

    
    if (!self.ishasUserLocation && !kObjectIsEmpty(userLocation.location)) {
        self.ishasUserLocation = YES;
        [self startUserLocation];
    }

    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
        }];
    }
}



//地图区域改变完成后会调用此接口
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(ydx_mapView:regionDidChangeAnimated:)]) {
        [self.delegate ydx_mapView:mapView regionDidChangeAnimated:animated];
    }
}


//地图将要发生移动时调用此接口
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction
{
    if ([self.delegate respondsToSelector:@selector(ydx_mapView:mapWillMoveByUser:)]) {
        [self.delegate ydx_mapView:mapView mapWillMoveByUser:wasUserAction];
    }
}

//地图移动结束后调用此接口
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    if ([self.delegate respondsToSelector:@selector(ydx_mapView:mapDidMoveByUser:)]) {
        [self.delegate ydx_mapView:mapView mapDidMoveByUser:wasUserAction];
    }
}





















#pragma mark --------------------------- locationManager Delegate -------------------------------------
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorString ;
    switch([error code]) {
        case kCLErrorDenied:
            errorString = @"访问定位服务被用户拒绝";
            [self alertforLoaction];
            break;
        case kCLErrorLocationUnknown:
            errorString = @"位置数据不可用";
            break;
        default:
            errorString = @"定位出现未知错误";
            break;
    }
}


- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    
    //[kGLOBAL setCurrentCity:reGeocode.city];
    
#pragma mark ---加约束
    //horizontalAccuracy 负值无效, 越大越不精确
    if (location.horizontalAccuracy < 100 && location.horizontalAccuracy > 0) {
        
        if ([self.delegate respondsToSelector:@selector(ydx_amapLocationManager:didUpdateLocation:reGeocode:)]) {
            [self.delegate ydx_amapLocationManager:manager didUpdateLocation:location reGeocode:reGeocode];
        }
    }
    
    
    
    
    
  
    
}
















#pragma mark --------------------------- search Delegate -------------------------------------

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    //NSLog(@"-------didFailWithError----------");
    if ([self.delegate respondsToSelector:@selector(ydx_mapSearchRequest:didFailWithError:)]) {
        [self.delegate ydx_mapSearchRequest:request didFailWithError:error];
    }

}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (self.reGeocodeSearchRequest != request) {
        return;
    }
    if (response.regeocode == nil) {
        return;
    }
    
    
    
    //[kGLOBAL setCurrentCity:response.regeocode.addressComponent.city];
    
    //CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
    //NSString *address = response.regeocode.formattedAddress;
    //NSLog(@"----(%.6f,%.6f)---address:%@----------",coordinate.latitude, coordinate.longitude, address);
    
    
    if ([self.delegate respondsToSelector:@selector(ydx_onReGeocodeSearchDone:response:)]) {
        [self.delegate ydx_onReGeocodeSearchDone:request response:response];
    }
    
    
    
    
    
}




































#pragma mark ---util
- (void)alertforLoaction
{
//    [YDXAlertView alertTitle:nil message:@"访问定位服务被用户拒绝!" cancelTitle:@"知道了" confirmTitle:@"去设置" block:^(NSInteger flag) {
//        if (flag) {
//            //跳转系统设置
//            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//            if([[UIApplication sharedApplication] canOpenURL:url])
//            {
//                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        }
//    }];
}



@end
