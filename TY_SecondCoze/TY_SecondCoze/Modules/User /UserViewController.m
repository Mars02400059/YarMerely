//
//  UserViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"


@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self appendSubsView];
}

- (void)appendSubsView {
    
#warning logo图片还没做, 记得添加背景图片
    TYQImageView *logoImageView = [[TYQImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 - 60 , self.view.height / 6, 120, 120)];
    logoImageView.layer.cornerRadius = logoImageView.width / 2;
    logoImageView.clipsToBounds = YES;
    [self.view addSubview:logoImageView];
    
    TYQLabel *titleLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(0, self.view.height / 2 - 50, self.view.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22.f];
#warning 题目太浮夸, 最好换掉
    titleLabel.text = @"聊天交友  首选亚聊";
    [self.view addSubview:titleLabel];
    
    TYQButton *rigisterButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    rigisterButton.frame = CGRectMake((self.view.width - 70) / 2, self.view.height / 5 * 3, 70, 30);
    rigisterButton.backgroundColor = [UIColor cyanColor];
    [rigisterButton setTitle:@"注册" forState:UIControlStateNormal];
    [rigisterButton addTarget:self action:@selector(rigisterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigisterButton];
    
    TYQButton *loginButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake((self.view.width - 70) / 2, self.view.height / 5 * 3 + rigisterButton.height + 20, rigisterButton.width, rigisterButton.height);
    loginButton.backgroundColor = [UIColor cyanColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];

}

- (void)rigisterButtonAction:(TYQButton *)rigisterButton {
    RegisterViewController *registerviewController = [[RegisterViewController alloc] init];
    [self presentViewController:registerviewController animated:YES completion:nil];

}

- (void)loginButtonAction:(TYQButton *)loginButtonAction {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self presentViewController:loginViewController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
