//
//  UINavigationController+MajqNavigationBar.h
//  MajqPopGesture
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MajqNavigationBar)

/// 自定义侧滑返回手势
@property(nonatomic,strong,readonly)UIPanGestureRecognizer *m_interactivePopGestureRecognizer;
@end
