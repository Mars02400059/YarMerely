//
//  LoginViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) TYQTextField *nameTextField;

@property (nonatomic, strong) TYQTextField *passwoksTextField;


@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self appendSubsView];
}

- (void)appendSubsView {
    
    TYQButton *leftButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 15, 70, 40);
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"< 返回" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    TYQLabel *titleLabel = [[TYQLabel alloc] initWithFrame:CGRectMake((self.view.width - 120) / 2, 15, 120, 40)];
    titleLabel.text = @"登录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:21.f];
    [self.view addSubview:titleLabel];
    
    TYQImageView *logoImageView = [[TYQImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 - 60 , self.view.height / 6, 120, 120)];
    logoImageView.layer.cornerRadius = logoImageView.width / 2;
    logoImageView.clipsToBounds = YES;
    [self.view addSubview:logoImageView];
    CGFloat nameTextFieldX = 40;
    CGFloat nameTextFieldWidth = self.view.width - nameTextFieldX * 2;
    CGFloat nameTextFieldHeight = 40;
    CGFloat nameTextFieldY = self.view.height / 2;
    self.nameTextField = [[TYQTextField alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldWidth, nameTextFieldHeight)];
    _nameTextField.backgroundColor = [UIColor grayColor];
    _nameTextField.placeholder = @"请输入用户名";
    [self.view addSubview:_nameTextField];
    
    CGFloat passwokTextFieldY = nameTextFieldY + nameTextFieldHeight + 20;
    self.passwoksTextField = [[TYQTextField alloc] initWithFrame:CGRectMake(nameTextFieldX, passwokTextFieldY, nameTextFieldWidth, nameTextFieldHeight)];
    _passwoksTextField.backgroundColor = [UIColor grayColor];
    _passwoksTextField.secureTextEntry = YES;
    _passwoksTextField.placeholder = @"请输入密码";
    [self.view addSubview:_passwoksTextField];
    
    TYQButton *loginButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(nameTextFieldX, passwokTextFieldY + nameTextFieldHeight + 50, nameTextFieldWidth, 45);
    loginButton.backgroundColor = [UIColor cyanColor];
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
}

- (void)leftButtonAction:(TYQButton *)leftButton {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)loginButtonAction:(TYQButton *)registerButton {
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_nameTextField.text password:_passwoksTextField.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            NSLog(@"登录成功");
            MainTabBarViewController *mainTabBarViewController = [[MainTabBarViewController alloc] init];
            [self presentViewController:mainTabBarViewController animated:YES completion:nil];
        }
    } onQueue:nil];
    
    
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
