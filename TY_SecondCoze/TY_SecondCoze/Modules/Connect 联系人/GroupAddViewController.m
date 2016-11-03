//
//  GroupAddViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/1.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupAddViewController.h"

@interface GroupAddViewController ()

@property (nonatomic, strong) TYQImageView *groupImageV;
@property (nonatomic, strong) TYQTextField *groupTextFiled;//请输入群名称
@property (nonatomic, strong) TYQButton *groupButton;
@property (nonatomic, strong) TYQLabel *groupLabel;

@end

@implementation GroupAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark --- UI配置
    
    self.groupTextFiled = [[TYQTextField alloc] initWithFrame:CGRectMake(10, 90, WIDTH - 20, 50)];
    _groupTextFiled.backgroundColor = [UIColor lightTextColor];
    _groupTextFiled.placeholder = @"请输入群名称";
    _groupTextFiled.layer.borderWidth = 1;
    _groupTextFiled.layer.cornerRadius = 5;
    _groupTextFiled.layer.masksToBounds = YES;
    _groupTextFiled.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_groupTextFiled];
    

    self.groupImageV = [[TYQImageView alloc] initWithFrame:CGRectMake(WIDTH / 3, HEIGHT / 3, WIDTH - WIDTH / 3 * 2, HEIGHT / 6)];
    _groupImageV.layer.cornerRadius = 5;
    _groupImageV.layer.masksToBounds = YES;
    _groupImageV.backgroundColor = [UIColor yellowColor];
    _groupImageV.image = [UIImage imageNamed:@"群"];
    [self.view addSubview:_groupImageV];
    
    self.groupLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(_groupTextFiled.frame.origin.x, _groupImageV.frame.origin.y + _groupImageV.frame.size.height + 20, _groupTextFiled.frame.size.width, _groupTextFiled.frame.size.height)];
    _groupLabel.text = @"三五好友, 随便聊聊";
    _groupLabel.font = [UIFont systemFontOfSize:22];
    _groupLabel.layer.cornerRadius = 5;
    _groupLabel.layer.masksToBounds = YES;
    _groupLabel.textAlignment = NSTextAlignmentCenter;
    _groupLabel.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:_groupLabel];
    
    
    self.groupButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _groupButton.frame = CGRectMake(20, HEIGHT / 3 * 2 , WIDTH - 40, HEIGHT / 12);
    _groupButton.backgroundColor = [UIColor greenColor];
    [_groupButton setTitle:@"立即创建" forState:UIControlStateNormal];
    _groupButton.layer.cornerRadius = 5;
    _groupButton.layer.masksToBounds = YES;
    [self.view addSubview:_groupButton];
    [_groupButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    //邀请新成员
     self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"加号"];
    
    // Do any additional setup after loading the view.
}

-(void) buttonAction:(UIButton *)button{
    
    EMError *error = nil;
    EMGroupStyleSetting *groupStyleSetting = [[EMGroupStyleSetting alloc] init];
    groupStyleSetting.groupMaxUsersCount = 500; // 创建500人的群，如果不设置，默认是200人。
    groupStyleSetting.groupStyle = eGroupStyle_PublicOpenJoin; // 创建不同类型的群组，这里需要才传入不同的类型
   
    EMGroup *group = [[EaseMob sharedInstance].chatManager createGroupWithSubject:self.groupTextFiled.text description:@"群组描述" invitees:nil initialWelcomeMessage:@"邀请您加入群组" styleSetting:groupStyleSetting error:&error];
    if(!error){
       
        NSLog(@"-- 创建成功 -- %@",group);
    
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

//左按钮
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
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
