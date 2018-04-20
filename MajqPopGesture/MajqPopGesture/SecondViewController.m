//
//  SecondViewController.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "SecondViewController.h"
#import "MCNavViewController.h"
#import "MajqNagigation.h"

#import "MajqTestScrollView.h"
@interface SecondViewController ()
{
    UIButton *_loginBtn;

}
@end

@implementation SecondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.m_interactivePopGestureRecognizerEdge = 150;
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self a];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,0,44,44);
    [btn setTitle:@"左边" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 22;
    
    [self.m_navigationBarView setupLeftBarButtonItem:btn callBack:^(MajqNavigationBarView *navigationBarView, UIView *leftItem) {
        NSLog(@"左边");
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
//    self.m_navigationBarView.navigationBarBackgroundImage = nil;
//    self.m_navigationBarView.navigationBarBackgroundColor = [UIColor clearColor];
//    self.m_navigationBarView.lineColor = [UIColor redColor];
    
    self.m_interactivePopGestureRecognizerEdge = 100;
}

- (void)a
{
    
    
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(150,100,100,100);
    [_loginBtn setTitle:@"push 03" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.backgroundColor = [UIColor orangeColor];
    
    _loginBtn.layer.cornerRadius = 22;
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
}

-(void)loginAction:(UIButton*)btn
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
