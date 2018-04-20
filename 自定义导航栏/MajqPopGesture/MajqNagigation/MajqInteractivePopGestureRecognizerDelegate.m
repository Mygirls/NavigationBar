//
//  MajqInteractivePopGestureRecognizerDelegate.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "MajqInteractivePopGestureRecognizerDelegate.h"
#import "UIViewController+MajqNavigationBar.h"
@interface MajqInteractivePopGestureRecognizerDelegate ()

@end


@implementation MajqInteractivePopGestureRecognizerDelegate

//MARK: - UIGestureRecognizerDelegate 协议

//开始进行手势识别时调用的方法，返回NO则结束，不再触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // 当导航控制器栈里面控制器的个数<=1 时，不触发手势
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    // 当禁止pop手势时
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    if (topViewController.m_interactivePopGestureRecognizerDisabled) {
        return NO;
    }
    
    // Ignore when the beginning location is beyond max allowed initial distance to left edge.
    // 当手势范围在设置的手势范围之外时
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.m_interactivePopGestureRecognizerEdge;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    
    // Ignore pan gesture when the navigation controller is currently in transition.
    // 当导航控制器处于过渡状态时忽略泛手势。
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    // 调用的处理程序/防止当手势开始在一个相反的方向。（从左到右）
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    BOOL isLeftToRight = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight;
    CGFloat multiplier = isLeftToRight ? 1 : - 1;
    if ((translation.x * multiplier) <= 0) {
        return NO;
    }
    
    return YES;
}

@end
