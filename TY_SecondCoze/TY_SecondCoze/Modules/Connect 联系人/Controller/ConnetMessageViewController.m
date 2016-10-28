//
//  ConnetMessageViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "ConnetMessageViewController.h"

@interface ConnetMessageViewController ()

@property (nonatomic, strong) TYQLabel *messageView;
@property (nonatomic, strong) TYQLabel *peerView;
@property (nonatomic, strong) TYQButton *okButton;
@property (nonatomic, strong) TYQButton *noButton;
@end

@implementation ConnetMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     此界面是收到附加消息的界面,从newVIewcontroller界面接收message的;
     就是验证信息
     */
    
    self.peerView = [TYQLabel new];
    _peerView.frame = CGRectMake(10, HEIGHT / 7, WIDTH / 3, 45);
    _peerView.backgroundColor = [UIColor whiteColor];
    _peerView.layer.cornerRadius = 5;
    _peerView.layer.masksToBounds = YES;
    _peerView.layer.borderWidth = 1;
    _peerView.textAlignment = NSTextAlignmentCenter;
    _peerView.text = @"验证信息";
    [self.view addSubview:_peerView];
    
    self.messageView = [TYQLabel new];
   _messageView.frame = CGRectMake(_peerView.frame.origin.x, _peerView.frame.origin.y + _peerView.frame.size.height + 50, WIDTH - 20, HEIGHT / 5);;
    _messageView.backgroundColor = [UIColor whiteColor];
    _messageView.layer.cornerRadius = 10;
    _messageView.layer.masksToBounds = YES;
    _messageView.layer.borderWidth = 1;
    [self.view addSubview:_messageView];
    
    self.okButton = [TYQButton buttonWithType:0];
    _okButton.backgroundColor = [UIColor greenColor];
    _okButton.frame = CGRectMake(_messageView.frame.origin.x, _messageView.frame.origin.y + _messageView.frame.size.height + 30 ,_messageView.frame.size.width, _peerView.frame.size.height);
    _okButton.layer.cornerRadius = 5;
    _okButton.layer.masksToBounds = YES;
    [_okButton setTitle:@"同意" forState:0];
    [self.view addSubview:_okButton];
    [_okButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:6];
    
    self.noButton = [TYQButton buttonWithType:0];
    _noButton.backgroundColor = [UIColor greenColor];
    _noButton.frame = CGRectMake(_okButton.frame.origin.x, _okButton.frame.origin.y + _okButton.frame.size.height + 20, _okButton.frame.size.width, _peerView.frame.size.height);
    _noButton.layer.cornerRadius = 5;
    _noButton.layer.masksToBounds = YES;
    [_noButton setTitle:@"拒绝" forState:0];
    [self.view addSubview:_noButton];
    [_noButton addTarget:self action:@selector(noButtonAction:) forControlEvents:6];
    
#pragma mark --- 验证信息内容
    self.messageView.text = _infoModelMessage.message;
    
    [self addNavigationBarView];
   self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --- 点击"同意"添加附加信息
-(void)agreeButtonAction:(UIButton *)button{

    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager acceptBuddyRequest:_infoModelMessage.username error:&error];
    if (isSuccess && !error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已同意" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark --- 点击"拒绝"添加附加信息
-(void) noButtonAction:(UIButton *)button{

    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager rejectBuddyRequest:_infoModelMessage.username reason:@"111111" error:&error];
    
    if (isSuccess && !error) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已拒绝" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];

    }

}


-(void) tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
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
