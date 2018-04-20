//
//  MajqNavViewController.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "MajqNavViewController.h"

@interface MajqNavViewController ()

@end

@implementation MajqNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void)setUpMajqNavigationBarConfig
{
    //MARK: - 隐藏系统默认的导航栏
    self.navigationBarHidden = NO ;
    self.navigationBar.hidden = YES ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
