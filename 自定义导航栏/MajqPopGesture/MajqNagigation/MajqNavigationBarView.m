//
//  MajqNavigationBarView.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "MajqNavigationBarView.h"
#import "MajqNavigationBarConfig.h"
#import "UIView+MajqNavigationBar.h"

@interface MajqNavigationBarView ()
{
    CGFloat _temAlpha;
}

/// 配置信息
@property(nonatomic,strong)MajqNavigationBarConfig *navigationBarConfig;

//相关控件
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UIImageView *backgroundImageView;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *lineView;

//临时保存自定义titleView
@property(nonatomic,strong)UIView *temTitleView;

//临时保存变量
@property(nonatomic,strong)NSMutableArray *temLeftItemArray;
@property(nonatomic,strong)NSMutableArray *temRightItemArray;

//回调block
@property(nonatomic,strong)void (^temLeftCallback)(MajqNavigationBarView *navigationBarView,UIView *leftItem);
@property(nonatomic,strong)void (^temRightCallback)(MajqNavigationBarView *navigationBarView,UIView *leftItem);

@end

@implementation MajqNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpConfig];
        
        [self setUpSubView];
    }
    return self;
}

- (void)setUpConfig
{
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _temAlpha = self.navigationBarConfig.navigationBarAlpha;
}

- (void)setUpSubView
{
    [self addSubview:self.backgroundImageView];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    
    if (self.navigationBarConfig.navigationBarBackgroundImage) {
        self.backgroundImageView.image = self.navigationBarConfig.navigationBarBackgroundImage;
    }
    
    if ([self.delegate respondsToSelector:@selector(majqNavigationBarView:)]) {
       _temTitleView = [self.delegate majqNavigationBarView:self];
    }
    
    if (_temTitleView != nil) {
        [self addSubview:_temTitleView];
    }
}

//MARK: -  导航栏按钮
- (void)navTitleViewWithTitle:(NSString *)titleString callBack:(void(^)(MajqNavigationBarView *v))callBack
{
    self.titleLabel.text = titleString;
    [self layoutNavSubViews];
    
    if (callBack) {
        callBack(self);
    }
}

- (void)setupLeftBarButtonItem:(UIView *)leftBarButtonItem
                      callBack:(void(^)(MajqNavigationBarView *navigationBarView,UIView *leftItem))callBack
{
    self.temLeftCallback = callBack;
    if (leftBarButtonItem == nil) {
        return;
    }
    
    if ([leftBarButtonItem isKindOfClass:[UIButton class]] || [leftBarButtonItem isKindOfClass:[UIControl class]]) {
        [(UIControl *)leftBarButtonItem addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapAction:)];
        [self addGestureRecognizer:tap];
    }
    [self.temLeftItemArray addObject:leftBarButtonItem];    //添加到数组
    
    [self addSubview:leftBarButtonItem];    //添加到父视图
}

- (void)setupRightBarButtonItem:(UIView *)rightBarButtonItem
                      callBack:(void(^)(MajqNavigationBarView *navigationBarView,UIView *leftItem))callBack
{
    self.temRightCallback = callBack;
    if (rightBarButtonItem == nil) {
        return;
    }
    
    if ([rightBarButtonItem isKindOfClass:[UIButton class]] || [rightBarButtonItem isKindOfClass:[UIControl class]]) {
        [(UIControl *)rightBarButtonItem addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapAction:)];
        [self addGestureRecognizer:tap];
    }
    
    [self.temRightItemArray addObject:rightBarButtonItem];  //添加到数组
    
    [self addSubview:rightBarButtonItem];   //添加到父视图
}

- (void)leftButtonClick:(UIButton *)btn
{
    if (self.temLeftCallback) {
        self.temLeftCallback(self, btn);
    }
}

- (void)leftTapAction:(UITapGestureRecognizer *)tap
{
    if (self.temLeftCallback) {
        self.temLeftCallback(self, tap.view);
    }
}

- (void)rightButtonClick:(UIButton *)btn
{
    if (self.temRightCallback) {
        self.temRightCallback(self, btn);
    }
}

- (void)rightTapAction:(UITapGestureRecognizer *)tap
{
    if (self.temRightCallback) {
        self.temRightCallback(self, tap.view);
    }
}


//MARK: -  set、get方法
- (void)setDelegate:(id<MajqNavigationBarViewDelegate>)delegate
{
    _delegate = delegate;
    
    if ([self.delegate respondsToSelector:@selector(majqNavigationBarView:)]) {
        _temTitleView = [self.delegate majqNavigationBarView:self];
    }
    
    if (_temTitleView != nil) {
        [self addSubview:_temTitleView];
    }
}
- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha
{
    _navigationBarAlpha = navigationBarAlpha;
    
    self.backgroundView.alpha = navigationBarAlpha ;
    self.lineView.alpha = navigationBarAlpha;
    
    if (_backgroundImageView) {
        self.backgroundImageView.alpha = navigationBarAlpha ;
    }
}

- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor
{
    _navigationBarBackgroundColor = navigationBarBackgroundColor;
    self.backgroundView.backgroundColor = navigationBarBackgroundColor;
    self.backgroundColor = navigationBarBackgroundColor ;
}

- (void)setNavigationBarBackgroundImage:(UIImage *)navigationBarBackgroundImage
{
    _navigationBarBackgroundImage = navigationBarBackgroundImage;
    self.backgroundImageView.image = navigationBarBackgroundImage;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    self.lineView.backgroundColor = lineColor;
}

//MARK: -  导航栏渐变



//MARK: - 重写UIView事件
- (void)willMoveToWindow:(nullable UIWindow *)newWindow
{
    [self layoutNavSubViews];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    [self m_bringSubviewToFront];
    
    [self layoutNavSubViews] ;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self m_layoutSubviews];
}

- (void)m_layoutSubviews
{
    UIViewController *vc = [self m_currentViewController];
    if (self.m_width != vc.view.m_width) {
        self.m_width = vc.view.m_width;
    }
    
    [self layoutNavSubViews];
    
//    NSLog(@"self = %@",NSStringFromCGRect(self.bounds));
//    NSLog(@"backview = %@",NSStringFromCGRect(self.backgroundView.bounds));
//    NSLog(@"backImagev = %@",NSStringFromCGRect(self.backgroundImageView.bounds));
//    NSLog(@"line = %@",NSStringFromCGRect(self.lineView.bounds));
}

//模拟系统导航栏：把自定义导航栏View 添加到当前控制器的最上方
- (void)m_bringSubviewToFront
{
    UIViewController *vc = [self m_currentViewController];
    [vc.view whenAddSubviewCallback:^(UIView *v) {
        [vc.view bringSubviewToFront:self];
    }];
    
    __weak typeof(self)weakSelf = self;
    [self whenAddSubviewCallback:^(UIView *v) {
        [weakSelf bringSubviewToFront:weakSelf.titleLabel];
        if (weakSelf.temTitleView) {
            [weakSelf bringSubviewToFront:weakSelf.temTitleView];
        }
    }];
}

- (void)layoutNavSubViews
{
    if (self.m_height != majqNavigationBarHeight()) {
        self.m_height = majqNavigationBarHeight() ;
    }
    
    if (!_titleLabel) return ;
    
    _titleLabel.hidden = NO ;
    __block CGFloat leftEdge = 20;
    __block CGFloat rightEdge = 20;
    CGFloat subViewY =  majqStatusBarHeight();

    //左边按钮
    [self.temLeftItemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *tempView = (UIView *)obj ;
        tempView.frame = CGRectMake(leftEdge, subViewY, tempView.m_width , tempView.m_height);
        leftEdge += tempView.m_width ;
    }];
    
    //右边按钮
    [self.temRightItemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *tempView = (UIView *)obj ;
        CGFloat tempViewX = self.m_width - rightEdge - tempView.m_width ;
        tempView.frame = CGRectMake(tempViewX, subViewY, tempView.m_width , tempView.m_height);
        rightEdge += tempView.m_width ;
    }];
    
    if (_temTitleView) {
        [self reloadNavigationBarWithTitleLabel:_temTitleView leftEdge:leftEdge rightEdge:rightEdge];
        self.titleLabel.hidden = YES;
        
        return;
    }

    self.titleLabel.hidden = NO;

    //title控件
    [self reloadNavigationBarWithTitleLabel:_titleLabel leftEdge:leftEdge rightEdge:rightEdge];
}

- (void)reloadNavigationBarWithTitleLabel:(UIView *)tempView leftEdge:(CGFloat)leftEdge rightEdge:(CGFloat)rightEdge
{
    CGFloat tempWidth = tempView.m_width ;    //获取控件的宽度
    if ([tempView isKindOfClass:[UILabel class]]) {
        tempWidth = [((UILabel *)tempView).text sizeWithAttributes:@{NSFontAttributeName: _titleLabel.font}].width ;
    }
    
    CGFloat tempX = leftEdge ;
    if (self.m_width - leftEdge - rightEdge < tempWidth) {//title显示不下。
        tempWidth = self.m_width - leftEdge - rightEdge ;
    } else{
        if (((self.m_width - tempWidth)/2 > leftEdge) && ((self.m_width - tempWidth)/2 > rightEdge)) {
            tempX = (self.m_width-tempWidth)/2 ;
        } else if((self.m_width-tempWidth)/2 > leftEdge){
            tempX = self.m_width - rightEdge - tempWidth ;
        }
    }
    
    if (tempView.m_height == 0) {
        tempView.m_height = majqNormalNavigationBarHeight();
    }
    CGFloat tempY = self.m_height - majqNormalNavigationBarHeight() + (majqNormalNavigationBarHeight()-tempView.m_height)/2 ;
    tempView.frame = CGRectMake(tempX, tempY, tempWidth, tempView.m_height) ;
}



//MARK: - 懒加载
- (MajqNavigationBarConfig *)navigationBarConfig
{
    if (_navigationBarConfig == nil) {
        _navigationBarConfig = [MajqNavigationBarConfig shareInstance];
    }
    return _navigationBarConfig;
}

- (UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _backgroundView.backgroundColor = self.navigationBarConfig.navigationBarBackgroundColor ;
        _backgroundView.alpha = _temAlpha ;
    }
    
    return _backgroundView;
}

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        _backgroundImageView.alpha = _temAlpha ;
        
        [self insertSubview:_backgroundImageView aboveSubview:self.backgroundView];
    }
    
    return _backgroundImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = self.navigationBarConfig.navigationBarTitleFont;
        _titleLabel.textColor = self.navigationBarConfig.navigationBarTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter ;
    }
    return _titleLabel;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.m_height - 0.5, self.m_width, 0.5)];
        _lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        _lineView.backgroundColor = self.navigationBarConfig.navigationBarLineColor;
    }
    return _lineView ;
}

- (NSMutableArray *)temLeftItemArray
{
    if (_temLeftItemArray == nil) {
        _temLeftItemArray = [NSMutableArray new];
    }
    return _temLeftItemArray;
}

- (NSMutableArray *)temRightItemArray
{
    if (_temRightItemArray == nil) {
        _temRightItemArray = [NSMutableArray new];
    }
    return _temRightItemArray;
}

@end
