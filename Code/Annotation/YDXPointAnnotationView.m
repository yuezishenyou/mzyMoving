//
//  YDXPointAnnotationView.m
//  ydx_bPassenger
//
//  Created by 杨广军 on 2018/7/17.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import "YDXPointAnnotationView.h"

// 小车 36 x 68

#define kWidth  18.f
#define kHeight 38.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  12.f
#define kPortraitHeight 20.f

#define kCalloutWidth   200.0
#define kCalloutHeight  120.0

@interface YDXPointAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation YDXPointAnnotationView

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        self.backgroundColor = [UIColor clearColor];
        
        self.portraitImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.portraitImageView];
        
    
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth, kHeight - 20, 100, 30)];
        self.nameLabel.numberOfLines    = 2;
        self.nameLabel.textAlignment    = NSTextAlignmentLeft;
        self.nameLabel.textColor        = [UIColor darkGrayColor];
        self.nameLabel.font             = [UIFont systemFontOfSize:10.f];
        [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
        [self addSubview:self.nameLabel];

    }
    
    return self;
}



#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

























//- (void)setSelected:(BOOL)selected
//{
//    [self setSelected:selected animated:NO];
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//
//    if (self.selected == selected) {
//        return;
//    }
//
//    if (selected)
//    {
//        if (self.calloutView == nil) {
//
//            self.calloutView = [[YDXVehicleBubble alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
//
//            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
//                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
//
//            [self.calloutView addSubview:self.tbView];
//
//        }
//
//        [self addSubview:self.calloutView];
//    }
//    else
//    {
//        [self.calloutView removeFromSuperview];
//    }
//
//
//    [super setSelected:selected animated:animated];
//
//}
//
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    BOOL inside = [super pointInside:point withEvent:event];
//
//    if (!inside && self.selected)
//    {
//        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
//    }
//    return inside;
//}












































@end









