//
//  LoginViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarViewController.h"
#import "sys/utsname.h"

static CGFloat const nameTextFieldX = 40;
static CGFloat const nameTextFieldHeight = 40;


@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) TYQTextField *nameTextField;

@property (nonatomic, strong) TYQTextField *passwoksTextField;

@property (nonatomic, strong) TYQButton *loginButton;

@property (nonatomic, strong) TYQImageView *logoImageView;
@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    titleLabel.text = @"登录";
     titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:21.f];
    [self.view addSubview:titleLabel];
    
    TYQImageView *logoImageView = [[TYQImageView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 60 , HEIGHT / 6, 120, 120)];
    logoImageView.image = [UIImage imageNamed:@"22"];
    logoImageView.layer.cornerRadius = logoImageView.width / 2;
    logoImageView.clipsToBounds = YES;
    [self.view addSubview:logoImageView];
    self.logoImageView = logoImageView;
    
#pragma mark --- textfiled
    
    CGFloat nameTextFieldWidth = WIDTH - nameTextFieldX * 2;
    CGFloat nameTextFieldY = HEIGHT / 2;
    
    
    self.nameTextField = [[TYQTextField alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldWidth,nameTextFieldHeight)];
    _nameTextField.delegate = self;//设置代理
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    _nameTextField.placeholder = @"请输入用户名123";//内容为空时默认文字
    _nameTextField.returnKeyType = UIReturnKeyDone;//设置放回按钮的样式
    _nameTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//设置键盘样式为数字
    [self.view addSubview:_nameTextField];
    
    
    CGFloat passwokTextFieldY = nameTextFieldY + nameTextFieldHeight + 20;
    self.passwoksTextField = [[TYQTextField alloc] initWithFrame:CGRectMake(nameTextFieldX, passwokTextFieldY, nameTextFieldWidth, nameTextFieldHeight)];
    _passwoksTextField.backgroundColor = [UIColor clearColor];
    _passwoksTextField.delegate = self;//设置代理
    _passwoksTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwoksTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    _passwoksTextField.placeholder = @"你的密码";//内容为空时默认文字
    _passwoksTextField.returnKeyType = UIReturnKeyDone;//设置放回按钮的样式
    _passwoksTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//设置键盘样式为数字
    [self.view addSubview:_passwoksTextField];
    
    
    //注册键盘出现与隐藏时候的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboadWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    [self.view addGestureRecognizer:gesture];

    
    
    
    TYQButton *loginButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(nameTextFieldX, passwokTextFieldY + nameTextFieldHeight + 50, nameTextFieldWidth, 45);
    loginButton.backgroundColor = [UIColor cyanColor];
    loginButton.layer.cornerRadius = 20;
    loginButton.layer.masksToBounds = YES;
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    self.loginButton = loginButton;
    
    
}

- (void)leftButtonAction:(TYQButton *)leftButton {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)loginButtonAction:(TYQButton *)registerButton {
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_nameTextField.text password:_passwoksTextField.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            
//            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            
            MainTabBarViewController *mainTabBarViewController = [[MainTabBarViewController alloc] init];
            mainTabBarViewController.tabBar.tintColor = [UIColor colorWithRed:0.320 green:0.736 blue:0.909 alpha:1.000];
            [self presentViewController:mainTabBarViewController animated:YES completion:nil];
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
                titleStr = @"用户名或密码输入错误";
                messageStr = @"请重新输入";
                _nameTextField.text = nil;
                _passwoksTextField.text = nil;
            }
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleStr message:messageStr preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];

            [self presentViewController:alertController animated:YES completion:nil];
        
        }
        
    } onQueue:nil];
    
    
}

+ (NSString *)platform {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

#pragma mark --- 对通知中心方法实现
//键盘出现时候调用的事件
-(void) keyboadWillShow:(NSNotification *)note{
    
    NSString * strModel  = [LoginViewController platform];
    NSLog(@" ======= %@", strModel);
    
    if ([strModel isEqualToString:@"iPhone5,4"])  {
        
        NSDictionary *info = [note userInfo];
        CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
        CGFloat offY = (HEIGHT-keyboardSize.height)-_nameTextField.frame.size.height;//屏幕总高度-键盘高度-UITextField高度
        CGFloat offy = (HEIGHT-keyboardSize.height)-_passwoksTextField.frame.size.height;
        CGFloat offL = (HEIGHT -keyboardSize.height) - _loginButton.frame.size.height;
        [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
        [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
        _nameTextField.frame = CGRectMake(nameTextFieldX, offY - 120 , WIDTH - nameTextFieldX * 2, nameTextFieldHeight);//UITextField位置的y坐标移动到offY
        _passwoksTextField.frame = CGRectMake(nameTextFieldX, offy - 65, WIDTH - nameTextFieldX * 2 , nameTextFieldHeight);
        _loginButton.frame = CGRectMake(nameTextFieldX, offL - 5, WIDTH - nameTextFieldX * 2, nameTextFieldHeight);
        _logoImageView.alpha = 0;
        [UIView commitAnimations];//开始动画效果

    }
    
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
    CGFloat offY = (HEIGHT-keyboardSize.height)-_nameTextField.frame.size.height;//屏幕总高度-键盘高度-UITextField高度
    CGFloat offy = (HEIGHT-keyboardSize.height)-_passwoksTextField.frame.size.height;
    CGFloat offL = (HEIGHT -keyboardSize.height) - _loginButton.frame.size.height;
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
    _nameTextField.frame = CGRectMake(nameTextFieldX, offY - 120 , WIDTH - nameTextFieldX * 2, nameTextFieldHeight);//UITextField位置的y坐标移动到offY
    _passwoksTextField.frame = CGRectMake(nameTextFieldX, offy - 65, WIDTH - nameTextFieldX * 2 , nameTextFieldHeight);
    _loginButton.frame = CGRectMake(nameTextFieldX, offL - 5, WIDTH - nameTextFieldX * 2, nameTextFieldHeight);
    _logoImageView.alpha = 0.5;
    [UIView commitAnimations];//开始动画效果
    
}

//键盘消失时候调用的事件
-(void)keyboardWillHide:(NSNotification *)note{
   [UIView beginAnimations:@"View Flip" context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];
    _nameTextField.frame = CGRectMake(nameTextFieldX, HEIGHT / 2, WIDTH - nameTextFieldX * 2, nameTextFieldHeight);//UITextField位置复原
    _passwoksTextField.frame = CGRectMake(nameTextFieldX, HEIGHT / 2 + nameTextFieldHeight + 20, WIDTH - nameTextFieldX * 2,nameTextFieldHeight);
    _loginButton.frame = CGRectMake(_nameTextField.frame.origin.x, _passwoksTextField.frame.origin.y + _passwoksTextField.frame.size.height + 50, _passwoksTextField.frame.size.width, _passwoksTextField.frame.size.height);
    _logoImageView.alpha = 1;
    [UIView commitAnimations];
}

////点击空白处隐藏键盘方法
-(void)hideKeyboard{
    
    [_nameTextField resignFirstResponder];
    [_passwoksTextField resignFirstResponder];
}

//
//开始编辑：
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

//点击return按钮所做的动作：
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}





























@end
