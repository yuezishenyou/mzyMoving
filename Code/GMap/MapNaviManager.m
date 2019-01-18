//
//  MapNaviManager.m
//  panssanger
//
//  Created by maoziyue on 2018/5/4.
//  Copyright © 2018年 Yuedao. All rights reserved.
//

#import "MapNaviManager.h"
//#import "SpeechSynthesizer.h"

//#import "YDXAlert.h"
//#import <MJExtension.h>



@interface MapNaviManager ()
<AMapNaviDriveManagerDelegate,
AMapNaviWalkManagerDelegate
>

@property (nonatomic, assign) BOOL isJourney;// 行程算距离

@end


@implementation MapNaviManager

+ (instancetype)shareManager
{
    static MapNaviManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[MapNaviManager alloc]init];
        }
    });
    return _manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    
}

- (AMapNaviDriveManager *)driveManager
{
    if (!_driveManager) {
        _driveManager = [AMapNaviDriveManager sharedInstance];
        _driveManager.delegate = self;
    }
    return _driveManager;
}

- (AMapNaviWalkManager *)walkManager
{
    if (!_walkManager) {
        _walkManager = [[AMapNaviWalkManager alloc] init];
        _walkManager.delegate = self;
        //[_walkManager setAllowsBackgroundLocationUpdates:YES];//
        //[_walkManager setPausesLocationUpdatesAutomatically:NO];//
    }
    return _walkManager;
}






- (void)ydx_calculateDriveRouteDistanceAndTimeToJourney:(BOOL)isJourney
{
//    self.isJourney = YES;
//    [GLOBAL.journeyList removeAllObjects];
//    NSInteger count = GLOBAL.addressArray.count;
//    if (count < 2) {
//        self.isJourney = NO;
//        return;
//    }
//
//    for (int i = 1; i < count; i ++)
//    {
//        YDXGJourneyModel *journeyModel = [[YDXGJourneyModel alloc] init];
//
//        YDXPOI *depa = GLOBAL.addressArray[i-1];  //出发
//        YDXPOI *dest = GLOBAL.addressArray[i];    //目的地
//
//        journeyModel.orderTypeId = 1;// dest.orderTypeId;
//        journeyModel.startPlace = depa.name;
//        journeyModel.startLat = depa.lat;
//        journeyModel.startLon = depa.lng;
//        journeyModel.endPlace = dest.name;
//        journeyModel.endLat = dest.lat;
//        journeyModel.endLon = dest.lng;
//
//        [GLOBAL.journeyList addObject:journeyModel];
//    }
//
//
//    YDXGJourneyModel *model = GLOBAL.journeyList.firstObject;
//    CGFloat startLat =  [model.startLat floatValue];
//    CGFloat startLon = [model.startLon floatValue];
//
//    CGFloat endLat = [model.endLat floatValue];
//    CGFloat endLon = [model.endLon floatValue];
//
//    if (startLat == 0 || startLon == 0 || endLat == 0 || endLon == 0) {
//        self.isJourney = NO;
//        if ([self.delegate respondsToSelector:@selector(ydx_driveManager:calculateDriveRouteError:)]) {
//            [self.delegate ydx_driveManager:self.driveManager calculateDriveRouteError:nil];
//        }
//        return;
//    }
//
//    CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake(startLat, startLon);
//    CLLocationCoordinate2D destCoordinate = CLLocationCoordinate2DMake(endLat, endLon);
//    [self ydx_calculateDriveRouteWithStartCoordinate:startCoordinate endCoordinate:destCoordinate];
    
}

//导航驾车路选计算成功后 算的距离
- (void)calculateDriveSuccess:(AMapNaviDriveManager *)driveManager
{
//    NSInteger time = driveManager.naviRoute.routeTime;
//    NSInteger meter = driveManager.naviRoute.routeLength;
//
//    if (GLOBAL.journeyList.count > 0) {
//        YDXGJourneyModel *journeyModel = GLOBAL.journeyList.firstObject;
//        journeyModel.distance = meter/ 1000;
//        journeyModel.aboutTime = time / 60;
//
//
//        //NSLog(@"----mmmmmmm:%@-------",journeyModel.mj_keyValues);
//
//        if ([self.delegate respondsToSelector:@selector(ydx_driveManager:calculateJourneySuccess:time:)]) {
//            [self.delegate ydx_driveManager:driveManager calculateJourneySuccess:meter time:time];
//        }
//
////        [MAPMANAGER ydx_clearOverlays];
////        [MAPMANAGER showNaviRoutes:driveManager.naviRoute];
//    }

}













#pragma mark ----------------------- public method ------------------------------------
- (void)ydx_calculateDriveRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate endCoordinate:(CLLocationCoordinate2D)endCoordinate
{
    
    AMapNaviPoint *origin = [AMapNaviPoint locationWithLatitude:startCoordinate.latitude longitude:startCoordinate.longitude];
    
    AMapNaviPoint *destion = [AMapNaviPoint locationWithLatitude:endCoordinate.latitude longitude:endCoordinate.longitude];
    
    [self.driveManager calculateDriveRouteWithStartPoints:@[origin]
                                                endPoints:@[destion]
                                                wayPoints:nil
                                          drivingStrategy:2];

}

//步行
- (void)ydx_calculateWalkRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate endCoordinate:(CLLocationCoordinate2D)endCoordinate
{
    AMapNaviPoint *origin = [AMapNaviPoint locationWithLatitude:startCoordinate.latitude longitude:startCoordinate.longitude];
    
    AMapNaviPoint *destion = [AMapNaviPoint locationWithLatitude:endCoordinate.latitude longitude:endCoordinate.longitude];
    
    [self.walkManager calculateWalkRouteWithStartPoints:@[origin]
                                              endPoints:@[destion]];

}




















#pragma mark ------------------------- 导航代理 -----------------------------------------

//--------------------------------------------------------------------------
//- 驾车代理
//--------------------------------------------------------------------------

//计算失败的回调
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error
{
    self.isJourney = NO;
    if ([self.delegate respondsToSelector:@selector(ydx_driveManager:calculateDriveRouteError:)]) {
        [self.delegate ydx_driveManager:driveManager calculateDriveRouteError:error];
    }
}

/** 计算驾车路径成功的回调 */
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    
    NSInteger time  = driveManager.naviRoute.routeTime;
    NSInteger meter = driveManager.naviRoute.routeLength;
    
    if ([self.delegate respondsToSelector:@selector(ydx_driveManager:calculateDriveRouteSuccess:time:)]) {
        [self.delegate ydx_driveManager:driveManager calculateDriveRouteSuccess:meter time:time];
    }
    
//    if (driveManager.naviRoute == nil) {
//        self.isJourney = NO;
//        if ([self.delegate respondsToSelector:@selector(ydx_driveManager:calculateDriveRouteError:)]) {
//            [self.delegate ydx_driveManager:driveManager calculateDriveRouteError:nil];
//        }
//        return;
//    }
//
//    if (self.isJourney == YES) {
//        self.isJourney = NO;
//        [self calculateDriveSuccess:driveManager];
//    }
    

    

}


















//--------------------------------------------------------------------------
//- 步行代理
//--------------------------------------------------------------------------
- (void)walkManager:(AMapNaviWalkManager *)walkManager error:(NSError *)error
{
    DLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)walkManager:(AMapNaviWalkManager *)walkManager onCalculateRouteFailure:(NSError *)error
{
    DLog(@"步行导航规划失败:{%ld - %@}", (long)error.code, error.localizedDescription);
    if ([self.delegate respondsToSelector:@selector(ydx_walkManager:calculateWalkRouteError:)]) {
        [self.delegate ydx_walkManager:walkManager calculateWalkRouteError:error];
    }
}

- (void)walkManagerOnCalculateRouteSuccess:(AMapNaviWalkManager *)walkManager
{
    NSInteger time  = walkManager.naviRoute.routeTime;
    NSInteger meter = walkManager.naviRoute.routeLength;
    //NSLog(@"====111=========计算步行路径成功的回调===time:%ld=====meter:%ld====",time000,meter000);
    
//    if (walkManager.naviRoute == nil) {
//        if ([self.delegate respondsToSelector:@selector(ydx_walkManager:calculateWalkRouteError:)]) {
//            [self.delegate ydx_walkManager:walkManager calculateWalkRouteError:nil];
//        }
//        return;
//    }
    
    
    if ([self.delegate respondsToSelector:@selector(ydx_walkManager:calculateWalkRouteSuccess:time:)]) {
        [self.delegate ydx_walkManager:walkManager calculateWalkRouteSuccess:meter time:time];
    }
    
}

- (void)walkManager:(AMapNaviWalkManager *)walkManager didStartNavi:(AMapNaviMode)naviMode
{
    DLog(@"步行导航 didStartNavi");
}

- (void)walkManagerNeedRecalculateRouteForYaw:(AMapNaviWalkManager *)walkManager
{
    DLog(@"步行导航 needRecalculateRouteForYaw");
}

- (void)walkManager:(AMapNaviWalkManager *)walkManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    
    //NSLog(@"步行导航 playNaviSoundString:{%ld:%@}------", (long)soundStringType, soundString);
    if ([self.delegate respondsToSelector:@selector(ydx_walkManager:playNaviSoundString:soundStringType:)]) {
        [self.delegate ydx_walkManager:walkManager playNaviSoundString:soundString soundStringType:soundStringType];
    }

    //[[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

- (void)walkManagerDidEndEmulatorNavi:(AMapNaviWalkManager *)walkManager
{// 导航停止的时候
    DLog(@"步行导航 didEndEmulatorNavi");
    if ([self.delegate respondsToSelector:@selector(ydx_walkManagerDidEndEmulatorNavi:)]) {
        [self.delegate ydx_walkManagerDidEndEmulatorNavi:walkManager];
    }
}

- (void)walkManagerOnArrivedDestination:(AMapNaviWalkManager *)walkManager
{
    DLog(@"onArrivedDestination");
}





// 和驾车导航相比，少了这几个方法
//- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager
//{
//    NSLog(@"needRecalculateRouteForTrafficJam");
//}
//
//- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex
//{
//    NSLog(@"onArrivedWayPoint:%d", wayPointIndex);
//}
//
//- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
//{
//    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
//}












@end
