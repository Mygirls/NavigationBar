//
//  MCNavViewController.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "MCNavViewController.h"

@interface MCNavViewController ()<UINavigationControllerDelegate>
{
    
}

@end

@implementation MCNavViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavConfig];
}

//MARK: - 相关配置设置
- (void)setUpNavConfig
{
    [self setUpMajqNavigationBarConfig];
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0 ) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}



@end
