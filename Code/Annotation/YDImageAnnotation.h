//
//  YDImageAnnotation.h
//  YDClient
//
//  Created by yuedao on 2017/9/20.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
//#import "YDXServicePlaceModel.h"

typedef NS_ENUM(NSInteger, YDImageAnnotationType){
    YDImageAnnotationTypeUp,
    YDImageAnnotationTypeDown,
    YDImageAnnotationWayPoint,
};

@interface YDImageAnnotation : MAPointAnnotation

@property (nonatomic, assign) YDImageAnnotationType type;

//@property (nonatomic, assign) BOOL currentService;

//@property (nonatomic, strong) YDXServicePlaceModel *model;

@end
