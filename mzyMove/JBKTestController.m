//
//  JBKTestController.m
//  mzyMove
//
//  Created by 杨广军 on 2019/1/16.
//  Copyright © 2019 maoziyue. All rights reserved.
//

#import "JBKTestController.h"
#import "MapManager.h"
#import "MapNaviManager.h"

#import "JBKLocations.h"

@interface JBKTestController ()<MapManagerDelegate,MapNaviManagerDelegate,JBKLocationsProtocol>

@property (nonatomic, strong) YDXAnimatedAnnotation *carAnnotation;
@property (nonatomic, strong) YDXDestAnnotation *endAnnotation;

@property (nonatomic, strong) MAPolyline *fullTraceLine;
@property (nonatomic, strong) MAPolyline *passedTraceLine;
@property (nonatomic, assign) NSInteger passedTraceCoordIndex;
@property (nonatomic, strong) NSArray *distanceArray;
@property (nonatomic, assign) double sumDistance;





@property (nonatomic, strong) JBKLocations *locations;
@property (nonatomic, strong) NSMutableArray *allPoints; //所有点
@property (nonatomic, assign) CLLocationCoordinate2D *all_coords;











@end

@implementation JBKTestController

- (void)dealloc {
    NSLog(@"---JBKTestController 释放-----");
    if (self.all_coords) {
        free(self.all_coords);
    }

    [kMAPMANAGER.mapView removeAnnotations:kMAPMANAGER.mapView.annotations];
    [kMAPMANAGER.mapView removeOverlays:kMAPMANAGER.mapView.overlays];
}



#pragma mark -------lazy

- (NSMutableArray *)allPoints {
    if (_allPoints == nil) {
        _allPoints = [[NSMutableArray alloc] init];
    }
    return _allPoints;
}

- (JBKLocations *)locations {
    if (_locations == nil) {
        _locations = [[JBKLocations alloc] init];
        _locations.delegate = self;
    }
    return _locations;
}



#pragma mark ------------------------------- 生命周期 -----------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小车移动";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    

    [self initData];
    
    [self initSubViews];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });


}

- (void)initData {
    
    self.passedTraceCoordIndex = 0;
}


- (void)initSubViews {
    
    [kMAPMANAGER locateMapViewInView:self.view frame:[[UIScreen mainScreen]bounds]];
    kMAPMANAGER.delegate = self;
}


- (void)loadData {
    
    //祁连山南路地铁站     121.367275,31.237625
    
    
    
    //祁连山南路388号     121.365917,31.231813
    //虹桥火车站          121.320205,31.193935
    //上海交通大学闵行校区  121.436908,31.025668

    
    self.carAnnotation = [[YDXAnimatedAnnotation alloc] init];
    self.carAnnotation.coordinate = CLLocationCoordinate2DMake(31.025668, 121.436908);
    self.carAnnotation.hasLine = YES;
    __weak typeof(self) weakSelf = self;
    [self.carAnnotation setStepBlock:^{
        [weakSelf updateTracePassed];
    }];
    
    
    
    self.endAnnotation = [[YDXDestAnnotation alloc] init];
    self.endAnnotation.coordinate = CLLocationCoordinate2DMake(31.231813, 121.365917);
    
    [kMAPMANAGER.mapView addAnnotations:@[self.carAnnotation, self.endAnnotation]];
    [kMAPMANAGER.mapView showAnnotations:@[self.carAnnotation,self.endAnnotation] edgePadding:UIEdgeInsetsMake(150, 50, 150, 50) animated:YES];
    
    
    kMAPNAVIMANAGER.delegate = self;
    [kMAPNAVIMANAGER ydx_calculateDriveRouteWithStartCoordinate:self.carAnnotation.coordinate endCoordinate:self.endAnnotation.coordinate];
    
    
}

- (void)updateTracePassed
{
    if(self.carAnnotation.isAnimationFinished) {
        return;
    }

    if(self.passedTraceLine) {
        [kMAPMANAGER.mapView removeOverlay:self.passedTraceLine];
    }


    // 自己写
    NSInteger needCount = self.passedTraceCoordIndex + 2;
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * needCount);
    memcpy(coords, self.all_coords, sizeof(CLLocationCoordinate2D) * (self.passedTraceCoordIndex + 1));
    coords[needCount - 1] = self.carAnnotation.coordinate;
    self.passedTraceLine = [MAPolyline polylineWithCoordinates:coords count:needCount];
    [kMAPMANAGER.mapView addOverlay:self.passedTraceLine];
    free(coords);


    
#if 0
    NSInteger totalCount = self.allPoints.count;
    self.passedTraceLine = [MAPolyline polylineWithCoordinates:self.all_coords count:totalCount];
    [kMAPMANAGER.mapView addOverlay:self.passedTraceLine];
#endif
    
    
}











#pragma mark ------------------------------- 定位加工 代理 -----------------------------------------
- (void)locations:(JBKLocations *)locations points:(NSArray *)points moveWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSInteger)count WithDuration:(CGFloat)duration {
    
    DLog(@"--------来了老弟------------\n");
    
    [self.allPoints addObjectsFromArray:points];
    NSInteger totalCount = self.allPoints.count;
    self.all_coords = malloc(sizeof(CLLocationCoordinate2D) * totalCount);
    for (int i = 0; i < totalCount; i++) {
        CLLocation *loc = self.allPoints[i];
        self.all_coords[i] = loc.coordinate;
    }
    
    __weak typeof(self) weakSelf = self;
    double speed = 120.0 / 3.6;
    float  dis = 120.0;
    [self.carAnnotation addMoveAnimationWithKeyCoordinates:coords count:count withDuration:(dis / speed) withName:nil completeCallback:^(BOOL isFinished) {
        weakSelf.passedTraceCoordIndex += count;
        weakSelf.title = [NSString stringWithFormat:@"小车移动(%ld)",(long)weakSelf.passedTraceCoordIndex];
    }];
    
    
}

#pragma mark------------------------------- 驾车规划画线 -------------------------------------------

// 画线操作
- (void)showNaviRoutes:(AMapNaviDriveManager *)driveManager
{
    
    if ([driveManager.naviRoutes count] <= 0) {
        return;
    }
    
    [kMAPMANAGER.mapView removeOverlays:kMAPMANAGER.mapView.overlays];
    AMapNaviRoute *aRoute = driveManager.naviRoute;
    int count = (int)[[aRoute routeCoordinates] count];
    //添加路径Polyline
    CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(count * sizeof(CLLocationCoordinate2D));
    for (int i = 0; i < count; i++) {
        AMapNaviPoint *coordinate = [[aRoute routeCoordinates] objectAtIndex:i];
        coords[i].latitude = [coordinate latitude];
        coords[i].longitude = [coordinate longitude];
    }
    self.fullTraceLine = [MAPolyline polylineWithCoordinates:coords count:count];
    [kMAPMANAGER.mapView addOverlay:self.fullTraceLine];
    free(coords);
    
}

#pragma mark ------------------------------- 驾车导航代理 -----------------------------------------
- (void)ydx_driveManager:(AMapNaviDriveManager *)driveManager calculateDriveRouteSuccess:(NSInteger)meter time:(NSInteger)time {
    
    NSLog(@"-----------路径多少米:%ld----秒:%ld---------",meter,time);
    [self showNaviRoutes:driveManager];
}
- (void)ydx_driveManager:(AMapNaviDriveManager *)driveManager calculateDriveRouteError:(NSError *)error {
    
}


#pragma mark ------------------------------- 更新定位信息 -----------------------------------------
- (void)ydx_amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    
    NSLog(@"--------------location:(%.6f,%.6f)----------------",location.coordinate.latitude,location.coordinate.longitude);
    [self.locations updateLocation:location];
}

#pragma mark ------------------------------- 两个神奇的方法 -----------------------------------------

- (MAAnnotationView *)ydx_mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if(annotation == self.carAnnotation) {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier2";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.canShowCallout = YES;
            
            UIImage *imge  =  [UIImage imageNamed:@"car1"];
            annotationView.image =  imge;
        }
        return annotationView;
    }
    else if ([annotation isKindOfClass:[YDXDestAnnotation class]]) {
        NSString *endIdentifier = @"endIdentifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:endIdentifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:endIdentifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable      = NO;
        }
        annotationView.image = [UIImage imageNamed:@"off"];
        annotationView.centerOffset = CGPointMake(0, -16);
        return annotationView;
    }

    return nil;
}
- (MAOverlayRenderer *)ydx_mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        if (overlay == self.fullTraceLine) {
            MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
            polylineRenderer.lineWidth = 5.f;
            polylineRenderer.strokeColor = [UIColor colorWithRed:0 green:0.47 blue:1.0 alpha:0.9];
            //polylineRenderer.strokeImage = [UIImage imageNamed:@"arrowTexture"];
            //polylineRenderer.lineCapType = kCGLineCapSquare;
            //polylineRenderer.lineDashType = 0;
            return polylineRenderer;
        }
        else if (overlay == self.passedTraceLine) {
            MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
            polylineRenderer.lineWidth = 6.f;
            polylineRenderer.strokeColor = [UIColor grayColor];
            return polylineRenderer;
        }
    }
    return nil;
}




























@end
