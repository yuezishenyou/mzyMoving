//
//  YDXAnimatedAnnotation.m
//  ydx_walk
//
//  Created by maoziyue on 2018/4/26.
//  Copyright © 2018年 maoziyue. All rights reserved.
//

#import "YDXAnimatedAnnotation.h"

@implementation YDXAnimatedAnnotation

- (void)step:(CGFloat)timeDelta {
    [super step:timeDelta];
    
    //NSLog(@"---timeDelta:%lf-----",timeDelta);
    
    if (self.hasLine && self.stepBlock) {
        
     
        
        self.stepBlock();
    }
    
}

// 这个是角度固定
//- (CLLocationDirection)rotateDegree {
//    return 0;
//}


@end
