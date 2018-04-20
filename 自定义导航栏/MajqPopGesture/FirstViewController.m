//
//  FirstViewController.m
//  MajqPopGesture
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 春风十里. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "MCNavViewController.h"
#import "MajqNagigation.h"

@interface FirstViewController ()<MajqNavigationBarViewDelegate>
{
    UIButton *_loginBtn;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    

    [self a];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,0,44,44);
    [btn setTitle:@"左边" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 22;
    
    
    [self.m_navigationBarView setupLeftBarButtonItem:btn callBack:^(MajqNavigationBarView *navigationBarView, UIView *leftItem) {
        NSLog(@"左边");
        leftItem.backgroundColor = [UIColor grayColor];
        
    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,0,44,44);
    [btn2 setTitle:@"右边" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor orangeColor];
    btn2.layer.cornerRadius = 22;
    
    [self.m_navigationBarView setupRightBarButtonItem:btn2 callBack:^(MajqNavigationBarView *navigationBarView, UIView *leftItem) {
        NSLog(@"右边");
        UIButton *b = (UIButton *)leftItem;
        b.selected = !b.selected;
        
        //状态栏样式
        if (b.selected) {
            self.m_preferredStatusBarStyle = UIStatusBarStyleDefault;
        } else {
            self.m_preferredStatusBarStyle = UIStatusBarStyleLightContent;
        }

    }];
    
    
    [self.m_navigationBarView navTitleViewWithTitle:@"标题测试1标题测试2标题测试3" callBack:^(MajqNavigationBarView *v) {
        
    }];
    
    
      self.m_navigationBarView.delegate = self;
}

- (UIView *)majqNavigationBarView:(MajqNavigationBarView *)navigationBarView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 88)];
    v.backgroundColor = [UIColor redColor];
    return v;
}

- (void)a
{
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(100,100,100,100);
    [_loginBtn setTitle:@"push 02" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.backgroundColor = [UIColor orangeColor];
    
    _loginBtn.layer.cornerRadius = 22;
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
}

-(void)loginAction:(UIButton*)btn
{
    
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
