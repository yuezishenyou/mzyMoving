//
//  YDXStartDestAnnotationView.h
//  HHCarMove
//
//  Created by maoziyue on 2018/5/7.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "YDXCalloutView.h"

@interface YDXStartDestAnnotationView : MAAnnotationView

@property (nonatomic, assign) BOOL hasPaoPao;//是否显示气泡

@property (nonatomic, strong) YDXCalloutView *calloutView;








@end
