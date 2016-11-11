//
//  AddManViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "AddManViewController.h"
@interface AddManViewController ()
@property (nonatomic, strong) TYQTextField *myTextFiled;
@property (nonatomic, strong) TYQTextField *messageTextFiled;
@property (nonatomic, strong) TYQButton *myButton;

@end

@implementation AddManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTextFiled = [TYQTextField new];
    _myTextFiled.frame = CGRectMake(10, HEIGHT / 7, WIDTH - 20, 45);
    _myTextFiled.layer.cornerRadius = 5;
    _myTextFiled.layer.masksToBounds = YES;
    _myTextFiled.layer.borderWidth = 1;
    _myTextFiled.placeholder = @"           请输入你要添加的账号";
    _myTextFiled.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myTextFiled];
    
    self.messageTextFiled = [TYQTextField new];
    _messageTextFiled.frame = CGRectMake(_myTextFiled.frame.origin.x, _myTextFiled.frame.origin.y + _myTextFiled.frame.size.height + 50, WIDTH - 20, HEIGHT / 4);;
    _messageTextFiled.backgroundColor = [UIColor whiteColor];
    _messageTextFiled.placeholder = @"           此时此刻说点什么";
    _messageTextFiled.layer.cornerRadius = 5;
    _messageTextFiled.layer.masksToBounds = YES;
    _messageTextFiled.layer.borderWidth = 1;
    [self.view addSubview:_messageTextFiled];
    
    
    self.myButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _myButton.frame = CGRectMake(_myTextFiled.frame.origin.x, HEIGHT / 3 * 2, _myTextFiled.frame.size.width, 55);
    _myButton.layer.cornerRadius = 5;
    _myButton.layer.masksToBounds = YES;
    _myButton.backgroundColor = [UIColor colorWithRed:0.39 green:0.78 blue:0.55 alpha:1.000];
    [_myButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:_myButton];
    [_myButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    
    
    
    // Do any additional setup after loading the view.
}


-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- button确认按钮(实现添加好友的确定键)
-(void)buttonAction:(UIButton *)button{
    
   if (![self.myTextFiled.text isEqualToString:@""]) {
       
       BmobQuery   *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
       // 添加playerName不是小明的约束条件
       [bquery whereKey:@"accountnumber" equalTo:_myTextFiled.text];
       [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
           if (array.count) {
               
               EMError *error = nil;
               BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:self.myTextFiled.text message:self.messageTextFiled.text error:&error];
               
               if (isSuccess && !error) {
                   
                   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请求发送成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                   UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                   [alert addAction:action];
                   
                   [self presentViewController:alert animated:YES completion:nil];
                   
               }
           } else {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您要添加的账号不存在" message:@"" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
               [alert addAction:action];
               
               [self presentViewController:alert animated:YES completion:nil];
           }
       }];

   } else {
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入您要添加的账号" message:@"" preferredStyle:UIAlertControllerStyleAlert];
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
