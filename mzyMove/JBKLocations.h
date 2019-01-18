//
//  JBKLocations.h
//  mzyMove
//
//  Created by 杨广军 on 2019/1/16.
//  Copyright © 2019 maoziyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapManager.h"

NS_ASSUME_NONNULL_BEGIN

@class JBKLocations;
@protocol JBKLocationsProtocol <NSObject>
@optional;

- (void)locations:(JBKLocations *)locations points:(NSArray <CLLocation *>*)points moveWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSInteger)count WithDuration:(CGFloat)duration;



@end

@interface JBKLocations : NSObject

@property (nonatomic, weak) id <JBKLocationsProtocol> delegate;

// 新的经纬度过来
- (void)updateLocation:(CLLocation *)location;










@end

NS_ASSUME_NONNULL_END
