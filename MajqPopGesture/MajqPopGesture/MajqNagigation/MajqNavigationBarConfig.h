//
//  MajqNavigationBarConfig.h
//  MajqPopGesture
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


///状态栏高度
CG_INLINE CGFloat majqStatusBarHeight() {
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    return statusBarFrame.size.height;
}

///导航栏高度44.0
CG_INLINE CGFloat majqNormalNavigationBarHeight() {
    return 44.0;
}

///NavigationBar 高度：状态栏高度 + 44.0
CG_INLINE CGFloat majqNavigationBarHeight() {
    CGFloat h = majqStatusBarHeight();
    return h + 44.0;
}

/// 屏幕的宽度
CG_INLINE CGFloat majqKScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

/// 屏幕的高度
CG_INLINE CGFloat majqKScreenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}

@interface MajqNavigationBarConfig : NSObject



/// 导航条基本设置的单例，用来设置全局导航条属性。(当需要改变导航条属性时，需要对改变的导航条单独设置)
/// 只需在APPdelegate里面设置一次，全局适用。
+ (instancetype)shareInstance ;

//MARK: -
/// 导航条的透明度
@property(nonatomic,assign)CGFloat navigationBarAlpha;

/// 导航条的背景色
@property(nonatomic,strong)UIColor *navigationBarBackgroundColor;

/// 导航条细线下的颜色
@property(nonatomic,strong)UIColor *navigationBarLineColor;

/// 导航条的背景图片
@property(nonatomic,strong)UIImage *navigationBarBackgroundImage;


/// titleLabel 字体大小
@property (nonatomic,strong)UIFont *navigationBarTitleFont;

/// titleLabel 字体颜色
@property (nonatomic,strong)UIColor *navigationBarTitleColor;




@end
