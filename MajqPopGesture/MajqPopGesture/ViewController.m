//
//  ViewController.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "MajqNagigation.h"

@interface ViewController ()
{
    UIButton *_loginBtn;
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
 
    [self.m_navigationBarView navTitleViewWithTitle:@"标题测试1" callBack:^(MajqNavigationBarView *v) {
    }];
 
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(100,100,100,100);
    [_loginBtn setTitle:@"push 01" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.backgroundColor = [UIColor orangeColor];
    
    _loginBtn.layer.cornerRadius = 22;
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
}



-(void)loginAction:(UIButton*)btn
{
    FirstViewController *vc = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end


