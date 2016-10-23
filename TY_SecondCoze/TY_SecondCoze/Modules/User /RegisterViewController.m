//
//  RegisterViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"


@interface RegisterViewController ()

@property (nonatomic, strong) TYQTextField *nameTextField;

@property (nonatomic, strong) TYQTextField *passwoksTextField;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self appendSubsView];
}

- (void)appendSubsView {
    
    TYQButton *leftButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 15, 70, 40);
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"〈 返回" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    TYQLabel *titleLabel = [[TYQLabel alloc] initWithFrame:CGRectMake((WIDTH - 120) / 2, 15, 120, 40)];
    titleLabel.text = @"注册";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:21.f];
    [self.view addSubview:titleLabel];
    
    TYQImageView *logoImageView = [[TYQImageView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 60 , HEIGHT / 6, 120, 120)];
    logoImageView.layer.cornerRadius = logoImageView.width / 2;
    logoImageView.clipsToBounds = YES;
    [self.view addSubview:logoImageView];
    CGFloat nameTextFieldX = 40;
    CGFloat nameTextFieldWidth = WIDTH - nameTextFieldX * 2;
    CGFloat nameTextFieldHeight = 40;
    CGFloat nameTextFieldY = HEIGHT / 2;
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
    
    TYQButton *registerButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(nameTextFieldX, passwokTextFieldY + nameTextFieldHeight + 50, nameTextFieldWidth, 45);
    registerButton.backgroundColor = [UIColor cyanColor];
    [registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
    [self.view addSubview:registerButton];

}

- (void)leftButtonAction:(TYQButton *)leftButton {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)registerButtonAction:(TYQButton *)registerButton {
    
//    [self.view endEditing:YES];
    
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_nameTextField.text password:_passwoksTextField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
            if (!error) {
            
                NSLog(@"注册成功");
                [self dismissViewControllerAnimated:YES completion:nil];
            
            } else {
            
                NSString *titleStr;
                NSString *messageStr;
                if ([_nameTextField.text isEqualToString:@""]) {
                    titleStr = @"请输入用户名";
                    messageStr = nil;
                } else if ([_passwoksTextField.text isEqualToString:@""]) {
                    titleStr = @"请输入密码";
                    messageStr = nil;
                } else {
                    titleStr = @"用户名已存在";
                    messageStr = @"请更换用户名";
                    _nameTextField.text = nil;
                    _passwoksTextField.text = nil;
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleStr message:messageStr preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
                
                [self presentViewController:alertController animated:YES completion:nil];

        }
    } onQueue:nil];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
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
