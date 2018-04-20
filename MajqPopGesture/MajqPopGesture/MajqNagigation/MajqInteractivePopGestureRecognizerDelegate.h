//
//  MajqInteractivePopGestureRecognizerDelegate.h
//  MajqPopGesture
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MajqInteractivePopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

/// 到航控制器对象
@property(nonatomic,weak)UINavigationController *navigationController;

@end
