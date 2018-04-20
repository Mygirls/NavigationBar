//
//  UIView+MajqNavigationBar.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "UIView+MajqNavigationBar.h"
#import <objc/runtime.h>
@implementation UIView (MajqNavigationBar)

//MARK: - 给分类添加属性，需要手动实现set、get 方法
- (MajqAddSubviewBlock)addSubviewCallback
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAddSubviewCallback:(MajqAddSubviewBlock)addSubviewCallback
{
    objc_setAssociatedObject(self, @selector(addSubviewCallback), addSubviewCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//MARK: - runtime 交换两个方法的实现【addSubview、easyAddSubview】，每次调用addSubview 的时候去监听，把导航view 添加到最上面
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //方法交换。当有视图加到这个view上时，得到通知
        Class viewClass = [UIView class];
        
        SEL originalSelector = @selector(addSubview:);
        SEL swizzledSelector = @selector(m_addSubview:);
        
        Method originalMethod = class_getInstanceMethod(viewClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(viewClass, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(viewClass,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(viewClass,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)m_addSubview:(UIView *)view
{
    [self m_addSubview:view];
    
    if (self.addSubviewCallback) {
        self.addSubviewCallback(view);
    }
}

- (void)whenAddSubviewCallback:(MajqAddSubviewBlock)callback
{
    self.addSubviewCallback = callback;
}

//MARK: - 得到当前控制器
- (UIViewController *)m_currentViewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return [self topViewController];
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


//MARK: -
- (CGFloat)m_height
{
    return self.frame.size.height;
}

- (void)setM_height:(CGFloat)m_height
{
    CGRect temp = self.frame;
    temp.size.height = m_height;
    self.frame = temp;
}

- (CGFloat)m_width
{
    return self.frame.size.width;
}

- (void)setM_width:(CGFloat)m_width
{
    CGRect temp = self.frame;
    temp.size.width = m_width;
    self.frame = temp;
}


@end
