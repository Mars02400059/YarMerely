//
//  AddManViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "AddManViewController.h"
@interface AddManViewController ()
<
EMChatManagerDelegate
>
@property (nonatomic, strong) TYQTextField *myTextFiled;
@property (nonatomic, strong) TYQButton *myButton;

@end

@implementation AddManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

    
    self.myTextFiled = [TYQTextField new];
    _myTextFiled.frame = CGRectMake(0, 84, WIDTH, 45);
    _myTextFiled.placeholder = @"           请输入你要添加的账号";
    _myTextFiled.backgroundColor = [UIColor redColor];
    [self.view addSubview:_myTextFiled];
    
    self.myButton = [TYQButton buttonWithType:0];
    _myButton.frame = CGRectMake(0, HEIGHT / 3 * 1, WIDTH, _myTextFiled.frame.size.height);
    _myButton.backgroundColor = [UIColor greenColor];
    [_myButton setTitle:@"确定" forState:0];
    [self.view addSubview:_myButton];
    [_myButton addTarget:self action:@selector(buttonAction:) forControlEvents:6];
    
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    
    
    
    // Do any additional setup after loading the view.
}


-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- button确认按钮(实现添加好友的确定键)
-(void)buttonAction:(UIButton *)button{
    
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:_myTextFiled.text message:@"我想加您为好友" error:&error];
    
    
    if (isSuccess && !error) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请求发送成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    
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
