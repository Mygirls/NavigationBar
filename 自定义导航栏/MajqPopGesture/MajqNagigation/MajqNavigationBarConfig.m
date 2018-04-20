//
//  MajqNavigationBarConfig.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "MajqNavigationBarConfig.h"

@implementation MajqNavigationBarConfig

static MajqNavigationBarConfig *_navigationShare = nil;

//MARK: - 单例
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _navigationShare = [[MajqNavigationBarConfig alloc] init];
    });
    return _navigationShare;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _navigationShare = [super allocWithZone:zone];
    });
    return _navigationShare;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _navigationShare;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _navigationShare;
}

//MARK: - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpConfig];
    }
    return self;
}

- (void)setUpConfig
{
    _navigationBarAlpha = 1.0f ;
    _navigationBarBackgroundColor = [UIColor whiteColor];
    _navigationBarLineColor = [UIColor groupTableViewBackgroundColor];
    
    _navigationBarTitleFont = [UIFont boldSystemFontOfSize:18];
    _navigationBarTitleColor = [UIColor darkTextColor];
}

//MARK: - set 方法
- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha
{
    if (_navigationBarAlpha < 0) {
        _navigationBarAlpha = 0 ;
        NSAssert(NO, @"navigationBarAlpha is illegal");
    }
    _navigationBarAlpha = navigationBarAlpha ;
}

- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor
{
    if ([navigationBarBackgroundColor isKindOfClass:[UIColor class]]) {
        _navigationBarBackgroundColor = navigationBarBackgroundColor ;
    } else{
        NSAssert(NO, @"navigationBarBackgroundColor is illegal");
    }
}

- (void)setNavigationBarLineColor:(UIColor *)navigationBarLineColor
{
    if ([navigationBarLineColor isKindOfClass:[UIColor class]]) {
        _navigationBarLineColor = navigationBarLineColor ;
    }
    else{
        NSAssert(NO, @"navigationBarLineColor is illegal");
    }
}

- (void)setNavigationBarBackgroundImage:(UIImage *)navigationBarBackgroundImage
{
    if ([navigationBarBackgroundImage isKindOfClass:[UIImage class]]) {
        _navigationBarBackgroundImage = navigationBarBackgroundImage ;
    }
    else{
        NSAssert(NO, @"navigationBarBackgroundImage is illegal");
    }
}


- (void)setNavigationBarTitleFont:(UIFont *)navigationBarTitleFont
{
    if ([navigationBarTitleFont isKindOfClass:[UIFont class]]) {
        _navigationBarTitleFont = navigationBarTitleFont ;
    }
    else{
        NSAssert(NO, @"navigationBarTitleFont is illegal");
    }
}

- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor
{
    if ([navigationBarTitleColor isKindOfClass:[UIColor class]]) {
        _navigationBarTitleColor = navigationBarTitleColor ;
    }
    else{
        NSAssert(NO, @"navigationBarTitleColor is illegal");
    }
}



@end
