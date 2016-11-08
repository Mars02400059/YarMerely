//
//  RegisterViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"



static CGFloat const nameTextFieldX = 40;
static CGFloat const nameTextFieldHeight = 40;

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) TYQTextField *nameTextField;

@property (nonatomic, strong) TYQTextField *passwoksTextField;

@property (nonatomic, strong) TYQButton *registerButton;

@property (nonatomic, strong) TYQImageView *logoImageView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

    [self appendSubsView];
}

- (void)appendSubsView {
    
#pragma mark --- 背景图片(还没添加)
    TYQImageView *backImageV = [[TYQImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//    backImageV.image = [UIImage imageNamed:@"3.jpg"];
    [self.view addSubview:backImageV];
    
    TYQButton *leftButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 15, 70, 40);
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"〈 返回" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    TYQLabel *titleLabel = [[TYQLabel alloc] initWithFrame:CGRectMake((WIDTH - 120) / 2, 15, 120, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"注册";
    titleLabel.layer.cornerRadius = 10;
    titleLabel.layer.masksToBounds = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:21.f];
    [self.view addSubview:titleLabel];
#pragma mark --- logo图片
    TYQImageView *logoImageView = [[TYQImageView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 60 , HEIGHT / 6, 120, 120)];
    logoImageView.image = [UIImage imageNamed:@"22"];
    logoImageView.layer.cornerRadius = logoImageView.width / 2;
    logoImageView.clipsToBounds = YES;
    [self.view addSubview:logoImageView];
    self.logoImageView = logoImageView;
#pragma mark --- 输入框
//    CGFloat nameTextFieldX = 40;
    CGFloat nameTextFieldWidth = WIDTH - nameTextFieldX * 2;
//    CGFloat nameTextFieldHeight = 40;
    CGFloat nameTextFieldY = HEIGHT / 2;
    self.nameTextField = [[TYQTextField alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldWidth, nameTextFieldHeight)];
    _nameTextField.delegate = self;//设置代理
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    _nameTextField.placeholder = @"请输入用户名哈哈";//内容为空时默认文字
    _nameTextField.returnKeyType = UIReturnKeyDone;//设置放回按钮的样式
    _nameTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//设置键盘样式为数字
    [self.view addSubview:_nameTextField];

    
    CGFloat passwokTextFieldY = nameTextFieldY + nameTextFieldHeight + 20;
    self.passwoksTextField = [[TYQTextField alloc] initWithFrame:CGRectMake(nameTextFieldX, passwokTextFieldY, nameTextFieldWidth, nameTextFieldHeight)];
    _passwoksTextField.delegate = self;//设置代理
    _passwoksTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwoksTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    _passwoksTextField.placeholder = @"请输入密码嘿嘿";//内容为空时默认文字
    _passwoksTextField.returnKeyType = UIReturnKeyDone;//设置放回按钮的样式
    _passwoksTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//设置键盘样式为数字
    [self.view addSubview:_passwoksTextField];
    
#pragma mark ---//注册键盘出现与隐藏时候的通知
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
    
    
    TYQButton *registerButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(nameTextFieldX, passwokTextFieldY + nameTextFieldHeight + 50, nameTextFieldWidth, 45);
    registerButton.backgroundColor = [UIColor cyanColor];
    registerButton.layer.cornerRadius = 20;
    registerButton.layer.masksToBounds = YES;
    [registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    self.registerButton = registerButton;
    

}

- (void)leftButtonAction:(TYQButton *)leftButton {
   

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerButtonAction:(TYQButton *)registerButton {
    
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_nameTextField.text password:_passwoksTextField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
            if (!error) {
            
                NSLog(@"注册成功");
                //在GameScore创建一条数据，如果当前没GameScore表，则会创建GameScore表
                BmobObject *gameScore = [BmobObject objectWithClassName:@"PersonInfo"];
                // 账号
                [gameScore setObject:_nameTextField.text forKey:@"accountnumber"];
                // 设置昵称
                [gameScore setObject:_nameTextField.text forKey:@"nickname"];
                // 设置age为18
                [gameScore setObject:@"不详" forKey:@"age"];
                // 设置性别
                [gameScore setObject:@"不详" forKey:@"sex"];
                // 设置签名
                [gameScore setObject:@"这个人很懒, 还没设置签名" forKey:@"autograph"];
                UIImage *image = [UIImage imageNamed:@"默认头像"];
                NSData *data = UIImagePNGRepresentation(image);;
                
                //图片保存的路径
                NSString * documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
                NSString *phonePath = [NSString stringWithFormat:@"/%@.png", _nameTextField.text];
                [fileManager createFileAtPath:[documentsPath stringByAppendingString:phonePath] contents:data attributes:nil];
                NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",documentsPath,  phonePath];
                NSLog(@"%@", filePath);
                BmobFile *file1 = [[BmobFile alloc] initWithFilePath:filePath];
                [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
                    //如果文件保存成功，则把文件添加到filetype列
                    if (isSuccessful) {
                        [gameScore setObject:file1  forKey:@"photoFile"];
                        //此处相当于新建一条记录,         //关联至已有的记录请使用 [obj updateInBackground];
                        [gameScore saveInBackground];
                        //打印file文件的url地址
                        NSLog(@"file1 url %@",file1.url);
                    }else{
                        //进行处理
                    }
                }];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];

                
                [self presentViewController:alertController animated:YES completion:nil];
            
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


#pragma mark --- 对通知中心方法实现
//键盘出现时候调用的事件
-(void) keyboadWillShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
    CGFloat offY = (HEIGHT-keyboardSize.height)-_nameTextField.frame.size.height;//屏幕总高度-键盘高度-UITextField高度
    CGFloat offy = (HEIGHT-keyboardSize.height)-_passwoksTextField.frame.size.height;
    CGFloat offL = (HEIGHT -keyboardSize.height) - _registerButton.frame.size.height;
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
    _nameTextField.frame = CGRectMake(nameTextFieldX, offY - 120 , WIDTH - nameTextFieldX * 2, nameTextFieldHeight);//UITextField位置的y坐标移动到offY
    _passwoksTextField.frame = CGRectMake(nameTextFieldX, offy - 65, WIDTH - nameTextFieldX * 2 , nameTextFieldHeight);
    _registerButton.frame = CGRectMake(nameTextFieldX, offL - 5, WIDTH - nameTextFieldX * 2, nameTextFieldHeight);
   _logoImageView.alpha = 0;
    [UIView commitAnimations];//开始动画效果
}

//键盘消失时候调用的事件
-(void)keyboardWillHide:(NSNotification *)note{
    [UIView beginAnimations:@"View Flip" context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];
    _nameTextField.frame = CGRectMake(nameTextFieldX, HEIGHT / 2, WIDTH - nameTextFieldX * 2, nameTextFieldHeight);//UITextField位置复原
    _passwoksTextField.frame = CGRectMake(nameTextFieldX, HEIGHT / 2 + nameTextFieldHeight + 20, WIDTH - nameTextFieldX * 2,nameTextFieldHeight);
    _registerButton.frame = CGRectMake(_nameTextField.frame.origin.x, _passwoksTextField.frame.origin.y + _passwoksTextField.frame.size.height + 50, _passwoksTextField.frame.size.width, _passwoksTextField.frame.size.height);
    _logoImageView.alpha = 1;
    [UIView commitAnimations];
}

//点击空白处隐藏键盘方法
-(void)hideKeyboard{
    [_nameTextField resignFirstResponder];
    [_passwoksTextField resignFirstResponder];
}

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
