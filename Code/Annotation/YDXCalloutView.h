//
//  YDXCalloutView.h
//  HHCarMove
//
//  Created by maoziyue on 2018/5/8.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDXCalloutView : UIView

/** 背景图片 */
@property (nonatomic ,weak) UIImageView *backImageView;

/**
 前来接驾 2分钟 或者 步行前往 10分钟
 @param desc 说明文字
 @param time 时间(3分钟)
 */
- (void)setDescription:(NSString *)desc addTime:(NSString *)time;



/**
 设置公里数和剩余时长
 @param mieage 距离公里数(数字)
 @param time 剩余时长(数字)
 */
- (void)setMileage:(NSString *)mieage addTime:(NSString *)time;



/**
 设置剩余公里数和已行驶距离收费
 @param mieage 距离终点公里数(数字)
 @param expenses 已行驶路程收费(数字)
 */
- (void)setMileage:(NSString *)mieage addExpenses:(NSString *)expenses;






@end
