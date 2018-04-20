//
//  UIViewController+MajqNavigationBar.h
//  MajqPopGesture
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MajqNavigationBarView;

@interface UIViewController (MajqNavigationBar)

/// 是否在导航中包含交互式弹出式手势。，默认NO
@property(nonatomic,assign)BOOL m_interactivePopGestureRecognizerDisabled;

/// 导航栏隐藏与否，默认NO：暂时未实现该功能，预留
@property(nonatomic,assign)BOOL m_prefersNavigationBarHidden;

/// 当开始交互pop时，max允许初始距离为左边缘。 手势。0默认情况下，这意味着它将忽略此限制。
@property(nonatomic,assign)CGFloat m_interactivePopGestureRecognizerEdge;

/// 自定义导航栏view
@property(nonatomic,strong)MajqNavigationBarView *m_navigationBarView;

///状态栏style
@property (nonatomic,assign)UIStatusBarStyle m_preferredStatusBarStyle;

@end
