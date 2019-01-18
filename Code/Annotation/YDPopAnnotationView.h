//
//  YDPopAnnotationView.h
//  YDClient
//
//  Created by yuedao on 2017/10/24.
//  Copyright © 2017年 YD. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
//#import "YDCustomMapPopView.h"
//#import "YDXServicePlaceModel.h"

@interface YDPopAnnotationView : MAAnnotationView

@property (nonatomic, assign) CLLocationCoordinate2D location;

@property (nonatomic, copy  ) NSString *number;

@property (nonatomic, strong) UIImage *portrait;

//@property (nonatomic, strong) YDXServicePlaceModel *model;

// 当前服务点
@property (nonatomic, assign) BOOL currentService;

- (void)touchEven;

- (void)setSize;

@end
