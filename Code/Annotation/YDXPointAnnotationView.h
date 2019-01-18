//
//  YDXPointAnnotationView.h
//  ydx_bPassenger
//
//  Created by 杨广军 on 2018/7/17.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface YDXPointAnnotationView : MAAnnotationView


@property (nonatomic, copy  ) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIView *calloutView;



@end
