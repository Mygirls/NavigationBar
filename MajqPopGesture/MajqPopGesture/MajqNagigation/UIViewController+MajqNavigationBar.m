//
//  UIViewController+MajqNavigationBar.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "UIViewController+MajqNavigationBar.h"
#import <objc/runtime.h>
#import "MajqNavigationBarView.h"
#import "MajqNavigationBarConfig.h"
@implementation UIViewController (MajqNavigationBar)
@dynamic m_navigationBarView;

//MARK: - 给分类添加属性，需要手动实现set、get 方法
- (BOOL)m_interactivePopGestureRecognizerDisabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setM_interactivePopGestureRecognizerDisabled:(BOOL)m_interactivePopGestureRecognizerDisabled
{
    objc_setAssociatedObject(self, @selector(m_interactivePopGestureRecognizerDisabled), @(m_interactivePopGestureRecognizerDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)m_prefersNavigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setM_prefersNavigationBarHidden:(BOOL)m_prefersNavigationBarHidden
{
    objc_setAssociatedObject(self, @selector(m_prefersNavigationBarHidden), @(m_prefersNavigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (CGFloat)m_interactivePopGestureRecognizerEdge
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setM_interactivePopGestureRecognizerEdge:(CGFloat)m_interactivePopGestureRecognizerEdge
{
    objc_setAssociatedObject(self, @selector(m_interactivePopGestureRecognizerEdge), @(m_interactivePopGestureRecognizerEdge), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIStatusBarStyle)m_preferredStatusBarStyle
{
    return [objc_getAssociatedObject(self, _cmd) integerValue] ;
}

- (void)setM_preferredStatusBarStyle:(UIStatusBarStyle)m_preferredStatusBarStyle
{
    if (self.m_preferredStatusBarStyle == m_preferredStatusBarStyle) {
        return ;
    }
    
    objc_setAssociatedObject(self, @selector(m_preferredStatusBarStyle), @(m_preferredStatusBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setNeedsStatusBarAppearanceUpdate];
}

//MARK: - 模拟系统导航栏
- (MajqNavigationBarView *)m_navigationBarView
{
    MajqNavigationBarView *navigationBarView = objc_getAssociatedObject(self, _cmd);
    if (navigationBarView == nil) {
        navigationBarView = [[MajqNavigationBarView alloc]initWithFrame:CGRectMake(0, 0, majqKScreenWidth(), majqNavigationBarHeight())];
        
        if (!self.navigationController) {
            NSAssert(NO, @"attention: this controller's navigationcontroller is null: %@",self);
        }
        
        if (self.navigationController.viewControllers.count > 1) {

        }
        
        [self willChangeValueForKey:NSStringFromClass([MajqNavigationBarView class])];
        objc_setAssociatedObject(self, @selector(m_navigationBarView), navigationBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:NSStringFromClass([MajqNavigationBarView class])];
        [self.view addSubview:navigationBarView];
    }
    return navigationBarView;
}



@end
