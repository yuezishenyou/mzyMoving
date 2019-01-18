//
//  ViewController.m
//  mzyMove
//
//  Created by 杨广军 on 2019/1/16.
//  Copyright © 2019 maoziyue. All rights reserved.
//

#import "ViewController.h"
#import "JBKTestController.h"
#import "MapManager.h"


static CLLocationCoordinate2D ss_coords[] =
{
    {39.976171, 116.349905},
    {39.976199, 116.349788},
    {39.976230, 116.349675},
    {39.976269, 116.349555},
    {39.976286, 116.349437},
    {39.976281, 116.349309},        //6
};

static CLLocationCoordinate2D jj_coords[] = {
    
    {39.976261, 116.349190},
    {39.976235, 116.349067},
    {39.976215, 116.348951},
    {39.976280, 116.348869},
    {39.976282, 116.348739},
    {39.976260, 116.348607},
    {39.976306, 116.348465},
    {39.976358, 116.348345},
    {39.976457, 116.348311},
};




@interface ViewController ()


@property (nonatomic, assign) CLLocationCoordinate2D *coords;

@property (nonatomic, assign) BOOL flag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"请触摸屏幕";
    
//    for (int i = 0; i < 6; i++) {
//        CLLocationCoordinate2D coor = self.coords[i];
//        NSLog(@"------viewDidLoad:(%.6f,%.6f)-------",coor.latitude,coor.longitude);
//    }
    
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    JBKTestController *vc = [[JBKTestController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
  

    
    
    
    
    
//    NSInteger count = sizeof(ss_coords) / sizeof(ss_coords[0]);
//    NSLog(@"----------总数量:%ld-------------",count);
//
//
//
//
//
//    if (self.flag == 0) {
//        self.flag = YES;
//
//        NSInteger mmmmcount = 3;
//        self.coords = malloc(sizeof(CLLocationCoordinate2D) * mmmmcount);
//        memcpy(self.coords, ss_coords, (sizeof(CLLocationCoordinate2D) * mmmmcount));
//
//
//        for (int i = 0; i < mmmmcount; i++) {
//            CLLocationCoordinate2D coor = self.coords[i];
//            NSLog(@"------(%.6f,%.6f)-------",coor.latitude,coor.longitude);
//        }
//
//
//
//
//    }
//    else {
//
//        NSInteger bbbbcount = 7;
//        self.coords = malloc(sizeof(CLLocationCoordinate2D) * bbbbcount);
//        memcpy(self.coords, jj_coords, (sizeof(CLLocationCoordinate2D) * bbbbcount));
//
//        for (int i = 0; i < bbbbcount; i++) {
//            CLLocationCoordinate2D coor = self.coords[i];
//            NSLog(@"------(%.6f,%.6f)-------",coor.latitude,coor.longitude);
//        }
//
//
//
//    }

    
    
    


    
    
    
    
    
    
    
    
}























@end
