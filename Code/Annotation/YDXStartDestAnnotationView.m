//
//  YDXStartDestAnnotationView.m
//  HHCarMove
//
//  Created by maoziyue on 2018/5/7.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import "YDXStartDestAnnotationView.h"



#define kWidth   150.f
#define kHeight  60.f


#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  12.f
#define kPortraitHeight 20.f

#define kCalloutWidth   200.0
#define kCalloutHeight  120.0



@interface  YDXStartDestAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation YDXStartDestAnnotationView

- (BOOL)canShowCallout {
    return NO;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.layer.masksToBounds = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setupUI];
        self.hasPaoPao = NO;

    }
    
    return self;
}

- (void)setupUI
{
    
    _calloutView = [[YDXCalloutView alloc] initWithFrame:CGRectMake(0, 0, 170, 46)];
    
    _calloutView.center = CGPointMake(10, -25);
    
    [self addSubview:_calloutView];
}


- (void)setHasPaoPao:(BOOL)hasPaoPao
{
    _hasPaoPao = hasPaoPao;
    if (hasPaoPao) {
        self.calloutView.hidden = NO;
    } else {
        self.calloutView.hidden = YES;
    }
}





















@end
