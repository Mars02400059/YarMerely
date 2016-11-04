//
//  GroupMixViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/3.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupMixViewController.h"

@interface GroupMixViewController ()

@property (nonatomic, strong) TYQTextField *IdTextFiled;
@property (nonatomic, strong) TYQTextField *nameFiled;
@property (nonatomic, strong) TYQTextField *messageFiled;
@property (nonatomic, strong) TYQButton *applyButton;

@end

@implementation GroupMixViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
//    EMError *error = nil;
//    // 申请加入需要审核的公开群组
//    [[EaseMob sharedInstance].chatManager applyJoinPublicGroup:@"1410329312753" withGroupname:@"群组名称" message:@"申请信息" error:&error];
//    if (!error) {
//        NSLog(@"申请成功");
//    }

#pragma mark --- 配置UI
    self.IdTextFiled = [[TYQTextField alloc]init];
    _IdTextFiled.frame = CGRectMake(10, HEIGHT / 8, WIDTH - 20, HEIGHT / 15);
    _IdTextFiled.backgroundColor = [UIColor whiteColor];
    _IdTextFiled.layer.borderWidth = 1;
    _IdTextFiled.layer.cornerRadius = 5;
    _IdTextFiled.layer.masksToBounds = YES;
    _IdTextFiled.placeholder = @"请输入群ID";
    [self.view addSubview:_IdTextFiled];
    
    self.nameFiled = [[TYQTextField alloc] init];
    _nameFiled.frame = CGRectMake(_IdTextFiled.frame.origin.x, _IdTextFiled.frame.origin.y + _IdTextFiled.frame.size.height + 20, _IdTextFiled.frame.size.width, _IdTextFiled.frame.size.height);
    _nameFiled.backgroundColor = [UIColor whiteColor];
    _nameFiled.layer.borderWidth = 1;
    _nameFiled.layer.cornerRadius = 5;
    _nameFiled.layer.masksToBounds = YES;
    _nameFiled.placeholder = @"请输入群名称";
    [self.view addSubview:_nameFiled];
    
    self.messageFiled = [[TYQTextField alloc] init];
    _messageFiled.frame = CGRectMake(_nameFiled.frame.origin.x, _nameFiled.frame.origin.y + _nameFiled.frame.size.height + 20, _nameFiled.frame.size.width, _nameFiled.frame.size.height);
    _messageFiled.backgroundColor = [UIColor whiteColor];
    _messageFiled.layer.cornerRadius = 5;
    _messageFiled.layer.masksToBounds = YES;
    _messageFiled.layer.borderWidth = 1;
    _messageFiled.placeholder = @"请输入申请信息";
    [self.view addSubview:_messageFiled];
    
    
    self.applyButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _applyButton.frame = CGRectMake(_IdTextFiled.frame.origin.x, HEIGHT / 2, _IdTextFiled.frame.size.width, _IdTextFiled.frame.size.height);
    _applyButton.backgroundColor = [UIColor greenColor];
    _applyButton.layer.cornerRadius = 5;
    _applyButton.layer.masksToBounds = YES;
    [_applyButton setTitle:@"确定申请" forState:UIControlStateNormal];
    [self.view addSubview:_applyButton];
    [self.applyButton addTarget:self action:@selector(appleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 申请加入该群
-(void)appleButtonAction:(UIButton *)button{
    
    EMError *error = nil;
    // 申请加入需要审核的公开群组
<<<<<<< HEAD
    [[EaseMob sharedInstance].chatManager applyJoinPublicGroup:_IdTextFiled.text withGroupname:_nameFiled.text message:_messageFiled.text error:&error];
    if (!error) {
        
        NSLog(@"申请==成功");
=======
    [[EaseMob sharedInstance].chatManager applyJoinPublicGroup:@"14781337321591" withGroupname:@"群组名称" message:@"申请信息" error:&error];
    if (!error) {
        
        NSLog(@"申请成功");
>>>>>>> c8f698d06e85ca552da78309367f910290cfc39c
    
    }
    
    
}

//键盘的事
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
