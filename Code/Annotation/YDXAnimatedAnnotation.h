//
//  YDXAnimatedAnnotation.h
//  ydx_walk
//
//  Created by maoziyue on 2018/4/26.
//  Copyright © 2018年 maoziyue. All rights reserved.
//  小车

#import <MAMapKit/MAMapKit.h>

typedef void (^CustomMovingAnnotationBlock)(void);


@interface YDXAnimatedAnnotation : MAAnimatedAnnotation

@property (nonatomic, copy) CustomMovingAnnotationBlock stepBlock;

@property (nonatomic,assign) BOOL hasLine;//有线要更新






@end
