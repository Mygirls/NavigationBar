//
//  UINavigationController+MajqNavigationBar.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "UINavigationController+MajqNavigationBar.h"
#import <objc/runtime.h>
#import "MajqInteractivePopGestureRecognizerDelegate.h"
#import "UIViewController+MajqNavigationBar.h"
@implementation UINavigationController (MajqNavigationBar)


//MARK: - runtime 交换两个方法的实现
+ (void)load
{
    //交换两个方法的实现【pushViewController:animated:、fd_pushViewController:animated:】
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(fd_pushViewController:animated:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)fd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.m_interactivePopGestureRecognizer]) {
        
        // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
        // 添加我们自己的手势
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.m_interactivePopGestureRecognizer];
        
        // Forward the gesture events to the private handler of the onboard gesture recognizer.
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
       
        // 设置代理[UIGestureRecognizerDelegate]
        self.m_interactivePopGestureRecognizer.delegate = self.fd_popGestureRecognizerDelegate;
       
        // 把系统侧滑的手势操作给自定义的手势
        [self.m_interactivePopGestureRecognizer addTarget:internalTarget action:internalAction];
        
        // Disable the onboard gesture recognizer.
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Forward to primary implementation.
    if (![self.viewControllers containsObject:viewController]) {
        [self fd_pushViewController:viewController animated:animated];
    }
    
//    if (self.viewControllers.count > 0 ) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
}

- (MajqInteractivePopGestureRecognizerDelegate *)fd_popGestureRecognizerDelegate
{
    MajqInteractivePopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    
    if (!delegate) {
        delegate = [[MajqInteractivePopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

//MARK: - 给分类添加属性，需要手动实现set、get 方法
- (UIPanGestureRecognizer *)m_interactivePopGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

// 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.m_preferredStatusBarStyle;
}

@end
