//
//  YDXCalloutView.m
//  HHCarMove
//
//  Created by maoziyue on 2018/5/8.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import "YDXCalloutView.h"
#import <QuartzCore/QuartzCore.h>

#define   kArrorHeight    (10)
#define   kBaseSize       (14)
#define   kNomalSize      (15)
#define   RGB(r,g,b,a)    [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]


@interface YDXCalloutView ()

@property (nonatomic ,weak) UILabel *detailLabel;

@end

@implementation YDXCalloutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupUI:frame];
    }
    return self;
}



- (void)setupUI:(CGRect)frame
{
    //背景图片
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backImageView = backImageView;
    backImageView.image = [UIImage imageNamed:@""];
    [self addSubview:self.backImageView];
    
    
    //详情显示
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, 21)];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.textColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1];
    self.detailLabel = detailLabel;
    self.detailLabel.text = @"正在获取数据……";
    self.detailLabel.font = [UIFont systemFontOfSize:kNomalSize];
    [self addSubview:self.detailLabel];
}



/**
 前来接驾 2分钟 或者 步行前往 10分钟
 @param desc 说明文字
 @param time 时间
 */
- (void)setDescription:(NSString *)desc addTime:(NSString *)time
{
    NSInteger lengFirst = desc.length;
    
    NSInteger lengSecond = time.length;
    
    NSString *detailStr = [NSString stringWithFormat:@"%@ %@",desc,time];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:detailStr];
    
    //说明
    [attributeString addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:kNomalSize]
                            range:NSMakeRange(0, lengFirst)];
    
    //时间
    [attributeString addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:kBaseSize]
                            range:NSMakeRange(lengFirst + 1, lengSecond)];
    
    
    //字体颜色
    [attributeString addAttribute:NSForegroundColorAttributeName
                            value:RGB(195, 149, 91, 1)
                            range:NSMakeRange(lengFirst + 1, lengSecond)];
    
    
    self.detailLabel.attributedText = attributeString;
    
    
}



/**
 设置公里数和剩余时长
 @param mieage 距离公里数
 @param time 剩余时长
 */
- (void)setMileage:(NSString *)mieage addTime:(NSString *)time {
    
    //公里数长度
    NSInteger lengFirst = mieage.length;
    //时长长度
    NSInteger lengSecond = time.length;
    
    
    //整体字符串长度
    NSString *detailStr = [NSString stringWithFormat:@"距您 %@ 公里 %@ 分钟",mieage,time];
    
    NSMutableAttributedString *attributeT = [[NSMutableAttributedString alloc]initWithString:detailStr];
    
    //距您
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:kBaseSize]
                       range:NSMakeRange(0, 2)];
    
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:kNomalSize]
                       range:NSMakeRange(detailStr.length-2, 2)];
    
    //公里
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:kBaseSize]
                       range:NSMakeRange(4 + lengFirst, 2)];
    //分钟
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:kBaseSize]
                       range:NSMakeRange(8 + lengFirst + lengSecond, 2)];
    
    //设置字体颜色
    [attributeT addAttribute:NSForegroundColorAttributeName
                       value:RGB(195, 149, 91, 1)
                       range:NSMakeRange(3, lengFirst)];
    
    [attributeT addAttribute:NSForegroundColorAttributeName
                       value:RGB(195, 149, 91, 1)
                       range:NSMakeRange(7 + lengFirst, lengSecond)];
    
    //普通字体颜色为85，85，85，1
    self.detailLabel.attributedText = attributeT;
}






/**
 设置剩余公里数和已行驶距离收费
 @param mieage 距离终点公里数
 @param expenses 已行驶路程收费
 */
- (void)setMileage:(NSString *)mieage addExpenses:(NSString *)expenses{
    
    expenses = [NSString stringWithFormat:@"%d",(int)ceil([expenses floatValue])];
    
    //公里数长度
    NSInteger lengFirst = mieage.length;
    //时长长度
    NSInteger lengSecond = expenses.length;
    
    
    //整体字符串长度
    NSString *detailStr = [NSString stringWithFormat:@"剩余%@公里 | 计费%@元",mieage,expenses];
    
    NSMutableAttributedString *attributeT = [[NSMutableAttributedString alloc]initWithString:detailStr];
    
    //剩余
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:kBaseSize]
                       range:NSMakeRange(0, 2)];
    
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:15]
                       range:NSMakeRange(detailStr.length-1, 1)];
    //公里
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:kBaseSize]
                       range:NSMakeRange(2 + lengFirst, 2)];
    //计费
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:kBaseSize]
                       range:NSMakeRange(7 + lengFirst, 2)];
    //元
    [attributeT addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:kBaseSize]
                       range:NSMakeRange(9 + lengFirst + lengSecond, 1)];
    
    //设置字体颜色
    [attributeT addAttribute:NSForegroundColorAttributeName
                       value:RGB(195, 149, 91, 1)
                       range:NSMakeRange(2, lengFirst)];
    
    [attributeT addAttribute:NSForegroundColorAttributeName
                       value:RGB(195, 149, 91, 1)
                       range:NSMakeRange(5 + lengFirst, 1)];
    
    [attributeT addAttribute:NSForegroundColorAttributeName
                       value:RGB(195, 149, 91, 1)
                       range:NSMakeRange(9 + lengFirst, lengSecond)];
    
    //普通字体颜色为85，85，85，1
    self.detailLabel.attributedText = attributeT;
}



























#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    //self.layer.shadowColor = [[UIColor whiteColor] CGColor];
    //self.layer.shadowOpacity = 1.0;
    //self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}









@end
