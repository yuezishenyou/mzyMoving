//
//  YDPopAnnotationView.m
//  YDClient
//
//  Created by yuedao on 2017/10/24.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDPopAnnotationView.h"
//#import "NSString+YDXSize.h"

#define kCalloutWidth       (100)
#define kCalloutHeight      (66)

#define kCustomViewWidth 40
#define KCustomViewHeight 45

@interface YDPopAnnotationView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *workImage;

@property (nonatomic, strong) UIView *backView;

@end

@implementation YDPopAnnotationView


- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {

            self.bounds = CGRectMake(0, 0, kCalloutWidth, kCalloutHeight);
            self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, 20)];
            self.nameLabel.backgroundColor  = [UIColor clearColor];
            self.nameLabel.layer.cornerRadius = 5;
            self.nameLabel.layer.masksToBounds = YES;
            self.nameLabel.textAlignment    = NSTextAlignmentCenter;
            self.nameLabel.textColor        = [UIColor whiteColor];
            self.nameLabel.font             = [UIFont systemFontOfSize:15];
            self.nameLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:self.nameLabel];
        
        self.backView = [[UIView alloc] initWithFrame:self.nameLabel.frame];
        self.backView .backgroundColor = [UIColor blackColor];
        self.backView .alpha = 0.3;
        self.backView .layer.cornerRadius = 5;
        self.backView .layer.masksToBounds = YES;
        [self addSubview:self.backView ];
        
        [self bringSubviewToFront:self.nameLabel];

        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kCalloutWidth - kCustomViewWidth) / 2, 20, kCustomViewWidth, KCustomViewHeight)];
        [self addSubview:self.portraitImageView];

//        self.userInteractionEnabled = YES;
//        UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]
//                                               initWithTarget:self action:@selector(longPressAction:)];
//
//        [self addGestureRecognizer:press];
    }
    return self;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (kObjectIsEmpty(kYD_USERDEFAULTS_READ_OBJ(@"token"))) {
//        return view;
//    }
//    if (!MACircleContainsCoordinate(self.location, GLOABL.currentCoor, kMeters)) {
//        return nil;
//    }
//    if (view == nil) {
//        CGPoint tempoint = [self.portraitImageView convertPoint:point fromView:self];
//        if (CGRectContainsPoint(self.portraitImageView.bounds, tempoint))
//        {
//            view = self.portraitImageView;
//            return view;
//        }else{
//            return nil;
//        }
//
//    }
//    return view;
//}


- (NSString *)number
{
    return self.nameLabel.text;
}

- (void)setNumber:(NSString *)number{
    self.nameLabel.text = number;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

//- (void)longPressAction:(UILongPressGestureRecognizer *)press{
//    DLog(@"=====================长按事件");
//    //[[NSNotificationCenter defaultCenter] postNotificationName:@"longPressIcon" object:self.model userInfo:nil];
//}

//- (void)touchEven{
//    if (self.currentService) {
//        if (!self.workImage.hidden) {
//            return;
//        }
//        [self showWorkImage];
//    }
//}

//- (UIImageView *)workImage{
//    if (!_workImage) {
//        _workImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mypoint_sign"]];
//        _workImage.hidden = YES;
////        _workImage.frame = CGRectMake(self.portraitImageView.x, CGRectGetMaxY(self.portraitImageView.frame), self.portraitImageView.width, self.portraitImageView.height);
//        [self addSubview:_workImage];
//    }
//    return _workImage;
//}

//- (void)showWorkImage{
////    self.workImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
//    self.workImage.hidden = NO;
////    self.workImage.backgroundColor = [UIColor redColor];
////    [UIView animateWithDuration:0.2 animations:^{
////        self.workImage.transform = CGAffineTransformMakeScale(1, 1);
//        self.workImage.frame = CGRectMake(self.portraitImageView.x, self.portraitImageView.y, self.portraitImageView.width, self.portraitImageView.height);
////    }];
//}

//- (void)setSize{
//    NSString *string = [NSString stringWithFormat:@"  %@  ", self.number];
//    CGSize size = [NSString sizeWithString:string fontSize:15 andWidth:kScreenSize.width / 2];
//    self.size = CGSizeMake(size.width, self.height);
//    self.nameLabel.frame = CGRectMake(0, 0, size.width, 20);
//    self.backView.frame =self.nameLabel.frame;
//    self.portraitImageView.frame = CGRectMake((self.width - kCustomViewWidth) / 2, 20, kCustomViewWidth, KCustomViewHeight);
//}

@end
