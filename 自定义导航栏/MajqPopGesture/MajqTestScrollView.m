//
//  MajqTestScrollView.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/20.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "MajqTestScrollView.h"

@implementation MajqTestScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x <= 0) {
            NSLog(@"返回YES");
            return YES;
        }
    }
    
    NSLog(@"返回NO");

    return NO;
}

@end
