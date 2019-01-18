//
//  MapManager.h
//  ydx_bPassenger
//
//  Created by maoziyue on 2018/5/15.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import "YDXStartAnnotation.h"     //开始大头针
#import "YDXDestAnnotation.h"      //下车大头针
#import "YDXUserAnnotation.h"      //用户大头针
#import "YDXAnimatedAnnotation.h"  //小车大头针
#import "YDXServiceAnnotation.h"   //服务点大头针
#import "YDImageAnnotation.h"

#import "YDXGuidePolyline.h"
#import "YDXStartDestAnnotationView.h"
#import "YDXPointAnnotationView.h"
#import "YDPopAnnotationView.h"
#import "YDXRunPolyline.h"        //行驶线
#import "YDXHistoryPolyline.h"    //历史线



@protocol MapManagerDelegate <NSObject>
@optional;
- (void)ydx_mapSearchRequest:(id)request didFailWithError:(NSError *)error;
- (void)ydx_onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response;
- (void)ydx_mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
- (void)ydx_mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction;
- (void)ydx_mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction;


- (MAAnnotationView *)ydx_mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation;
- (MAOverlayRenderer *)ydx_mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay;


- (void)ydx_amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode;

@end



#define kMAPMANAGER ([MapManager shareManager])
@interface MapManager : NSObject
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, weak  ) id <MapManagerDelegate> delegate;

+ (instancetype)shareManager;
- (void)setConfiguration; //设置key
- (void)locateMapViewInView:(UIView *)supView frame:(CGRect)frame;

//回到当前定位点
- (void)startUserLocation;
//逆地理搜索
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate;
//显示地图中心区域
- (void)setReginCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;





















@end
