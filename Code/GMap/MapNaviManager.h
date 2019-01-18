//
//  MapNaviManager.h
//  panssanger
//
//  Created by maoziyue on 2018/5/4.
//  Copyright © 2018年 Yuedao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>




@protocol MapNaviManagerDelegate <NSObject>
@optional;
// 驾车
- (void)ydx_driveManager:(AMapNaviDriveManager *)driveManager calculateDriveRouteSuccess:(NSInteger)meter time:(NSInteger)time;
- (void)ydx_driveManager:(AMapNaviDriveManager *)driveManager calculateDriveRouteError:(NSError *)error;
//- (void)ydx_driveManager:(AMapNaviDriveManager *)driveManager calculateJourneySuccess:(NSInteger)meter time:(NSInteger)time;



// 步行
- (void)ydx_walkManager:(AMapNaviWalkManager *)walkManager calculateWalkRouteSuccess:(NSInteger)meter time:(NSInteger)time;
- (void)ydx_walkManager:(AMapNaviWalkManager *)walkManager calculateWalkRouteError:(NSError *)error;
- (void)ydx_walkManager:(AMapNaviWalkManager *)walkManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType;
- (void)ydx_walkManagerDidEndEmulatorNavi:(AMapNaviWalkManager *)walkManager;


@end






//***************************************************
#define kMAPNAVIMANAGER ([MapNaviManager shareManager])
@interface MapNaviManager : NSObject

+ (instancetype) shareManager;
@property (nonatomic, strong) AMapNaviDriveManager *driveManager;
@property (nonatomic, strong) AMapNaviWalkManager  *walkManager;
@property (nonatomic, weak  ) id <MapNaviManagerDelegate> delegate;// 注意代理是在哪个地方


//驾车
- (void)ydx_calculateDriveRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate
                                     endCoordinate:(CLLocationCoordinate2D)endCoordinate;


//步行
- (void)ydx_calculateWalkRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate
                                    endCoordinate:(CLLocationCoordinate2D)endCoordinate;



- (void)ydx_calculateDriveRouteDistanceAndTimeToJourney:(BOOL)isJourney;






@end
