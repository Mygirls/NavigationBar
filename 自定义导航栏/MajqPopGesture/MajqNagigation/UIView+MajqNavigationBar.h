//
//  UIView+MajqNavigationBar.h
//  MajqPopGesture
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MajqAddSubviewBlock)(UIView *v);

@interface UIView (MajqNavigationBar)

/// 回调block
@property(nonatomic,strong)MajqAddSubviewBlock addSubviewCallback;


@property (nonatomic, assign) CGFloat m_height;
@property (nonatomic, assign) CGFloat m_width;

/// 得到当前控制器
- (UIViewController *)m_currentViewController;

/**
 当view addSubview 时候，回调

 @param callback MajqAddSubviewBlock:参数view
 */
- (void)whenAddSubviewCallback:(MajqAddSubviewBlock)callback;

@end
