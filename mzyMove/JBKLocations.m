//
//  JBKLocations.m
//  mzyMove
//
//  Created by 杨广军 on 2019/1/16.
//  Copyright © 2019 maoziyue. All rights reserved.
//

#import "JBKLocations.h"
#import <MAMapKit/MAMapKit.h>
#import "AMapRouteRecord.h"


#define kTempTraceLocationCount  (5)

@interface JBKLocations ()

@property (nonatomic, strong) MATraceManager *traceManager;
@property (nonatomic, strong) AMapRouteRecord *currentRecord;

@property (nonatomic, strong) NSMutableArray <CLLocation *>*points;
@property (nonatomic, strong) NSMutableArray <CLLocation *>*tempTraceLocations; //临时纠偏数组




@end

@implementation JBKLocations

#pragma mark -------lazy
- (NSMutableArray <CLLocation *>*)points {
    if (_points == nil) {
        _points = [[NSMutableArray alloc] init];
    }
    return _points;
}

- (NSMutableArray <CLLocation *>*)tempTraceLocations {
    if (_tempTraceLocations == nil) {
        _tempTraceLocations = [[NSMutableArray alloc] init];
    }
    return _tempTraceLocations;
}

- (MATraceManager *)traceManager {
    if (_traceManager == nil) {
        _traceManager = [[MATraceManager alloc] init];
    }
    return _traceManager;
}

- (AMapRouteRecord *)currentRecord {
    if (_currentRecord == nil) {
        _currentRecord = [[AMapRouteRecord alloc] init];
    }
    return _currentRecord;
}

#pragma mark ------cycle life
- (instancetype) init {
    if (self = [super init]) {
        
    }
    return self;
}



#pragma mark ------------ methods --------------------
#pragma mark --新的血液
- (void)updateLocation:(CLLocation *)location {
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    if (coordinate.latitude <= 0 || coordinate.longitude <= 0) {
        return;
    }
    if (location.horizontalAccuracy < 100 && location.horizontalAccuracy > 0)
    {
        double lastDis = [location distanceFromLocation:self.currentRecord.endLocation];
        NSLog(@"---------这个距离:(%.2f)-----------",lastDis);
        
        if (lastDis < 0.0 || lastDis > 10) {
            
            [self.currentRecord addLocation:location];
            
            // 其实这里可以置小车为中间点 也可以画线
            //[kMAPMANAGER.mapView setCenterCoordinate:location.coordinate animated:YES];
        
            [self.tempTraceLocations addObject:location];
            if (self.tempTraceLocations.count >= kTempTraceLocationCount) {
                NSLog(@"---------开始纠偏----------");
                [self queryTraceWithLocations:self.tempTraceLocations withSaving:NO];
                [self.tempTraceLocations removeAllObjects];
                
                // 把最后一个再add一遍，否则会有缝隙
                [self.tempTraceLocations addObject:location];
            }
        }
    }
}

#pragma mark --画线三点成线
- (void)movingByPoints:(NSArray *)points {
    
    
    // 不纠偏的处理方法
    //    if (self.points.count >= kTempTraceLocationCount) {
    //        NSArray *copyArray = [NSArray arrayWithArray:self.points]; //这里需要测试下
    //        [self.points removeAllObjects];
    //        [self movingByPoints:copyArray];
    //    }
    //    [self.points addObject:location];
    
    NSInteger count = points.count;
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * count);
    for (int i = 0; i < count; i++) {
        CLLocation *loc = points[i];
        CLLocationCoordinate2D coor = loc.coordinate;
        coords[i] = coor;
    }
    if ([self.delegate respondsToSelector:@selector(locations:points:moveWithCoordinates:count:WithDuration:)]) {
        [self.delegate locations:self points:points moveWithCoordinates:coords count:count WithDuration:count];
    }

    if (coords) {
        free(coords);
    }
}




#pragma mark --纠偏处理
- (void)queryTraceWithLocations:(NSArray <CLLocation *>*)locations withSaving:(BOOL)saving
{
    if (locations.count < 2) {
        return;
    }
    
    NSMutableArray *mArr = [NSMutableArray array];
    for (CLLocation *loc in locations) {
        MATraceLocation *tLoc = [[MATraceLocation alloc] init];
        tLoc.loc = loc.coordinate;
        
        tLoc.speed = loc.speed * 3.6; //m/s  转 km/h
        tLoc.time = [loc.timestamp timeIntervalSince1970] *1000;
        tLoc.angle = loc.course;
        [mArr addObject:tLoc];
    }
    
    __weak typeof(self) weakSelf = self;
    __unused NSOperation *op = [self.traceManager queryProcessedTraceWith:mArr type:-1 processingCallback:nil finishCallback:^(NSArray<MATracePoint *> *points, double distance) {
        
        NSLog(@"--------纠偏完成:%ld---------",points.count);
        [weakSelf updateUserlocationTitleWithDistance:distance];
        [weakSelf addFullTrace:points];
        
    } failedCallback:^(int errorCode, NSString *errorDesc) {
        
        NSLog(@"--------纠偏失败:%@---------",errorDesc);
        
    }];
    
    
}


- (void)addFullTrace:(NSArray<MATracePoint*> *)tracePoints {
    
    NSInteger count = tracePoints.count;
    
    if (count < 2) {
        return ;
    }
    
    CLLocationCoordinate2D *pCoords = malloc(sizeof(CLLocationCoordinate2D) * count);
    if (!pCoords) {
        return;
    }
    
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < count; ++i) {
        //1.结构体
        MATracePoint *p = [tracePoints objectAtIndex:i];
        CLLocationCoordinate2D *pCur = pCoords + i;
        pCur->latitude = p.latitude;
        pCur->longitude = p.longitude;
        //2.经纬度数组
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:p.latitude longitude:p.longitude];
        [points addObject:loc];
    }
    
    if ([self.delegate respondsToSelector:@selector(locations:points:moveWithCoordinates:count:WithDuration:)]) {
        [self.delegate locations:self points:points moveWithCoordinates:pCoords count:count WithDuration:count];
    }
    
    if (pCoords) {
        free(pCoords);
    }
    
    
    
}



- (void)updateUserlocationTitleWithDistance:(double)distance {
    
      //self.totalTraceLength += distance; //
    
}



















@end
