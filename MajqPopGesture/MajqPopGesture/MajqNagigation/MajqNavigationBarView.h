//
//  MajqNavigationBarView.h
//  MajqPopGesture
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MajqNavigationBarView;

@protocol MajqNavigationBarViewDelegate <NSObject>

@optional

/// 自定义titleView
- (UIView *)majqNavigationBarView:(MajqNavigationBarView *)navigationBarView;

@end

@interface MajqNavigationBarView : UIView

@property(nonatomic,weak)id<MajqNavigationBarViewDelegate> delegate;

/// 导航条的背景图片
@property(nonatomic,strong)UIImage *navigationBarBackgroundImage;

/// 导航条的透明度
@property(nonatomic,assign)CGFloat navigationBarAlpha;

/// 导航条的背景色
@property(nonatomic,strong)UIColor *navigationBarBackgroundColor;

/// 导航条细线下的颜色
@property(nonatomic,strong)UIColor *lineColor;

/// 左边按钮数组
//@property(nullable,nonatomic,copy) NSArray<UIView *> *leftBarButtonItems;
//
///// 右边按钮数组
//@property(nullable,nonatomic,copy) NSArray<UIView *> *rightBarButtonItems;

/**
 设置title

 @param titleString 标题
 @param callBack 回调
 */
- (void)navTitleViewWithTitle:(NSString *)titleString callBack:(void(^)(MajqNavigationBarView *v))callBack;


/**
 <#Description#>

 @param leftBarButtonItem <#leftBarButtonItem description#>
 @param callBack <#callBack description#>
 */
- (void)setupLeftBarButtonItem:(UIView *)leftBarButtonItem
                      callBack:(void(^)(MajqNavigationBarView *navigationBarView,UIView *leftItem))callBack;


/**
 <#Description#>

 @param rightBarButtonItem <#rightBarButtonItem description#>
 @param callBack <#callBack description#>
 */
- (void)setupRightBarButtonItem:(UIView *)rightBarButtonItem
                       callBack:(void(^)(MajqNavigationBarView *navigationBarView,UIView *leftItem))callBack;
@end
