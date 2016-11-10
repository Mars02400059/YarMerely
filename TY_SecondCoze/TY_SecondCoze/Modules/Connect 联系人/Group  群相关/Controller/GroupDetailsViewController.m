//
//  GroupDetailsViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/2.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import <EMGroup.h>
#import <EMChatManagerGroupDelegate.h>
#import "InfoModel.h"
#import "GroupChatViewController.h"
#import "MessageChatViewController.h"

@interface GroupDetailsViewController ()

<
EMChatManagerDelegate
>

@property (nonatomic, strong) TYQLabel *groupIdLabel;//请输入群id
@property (nonatomic, strong) TYQLabel *groupSubjectLabel;//名称
@property (nonatomic, strong) TYQImageView *groupImageV;
@property (nonatomic, strong) TYQButton *groupChatButton;

@end

@implementation GroupDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     获取群详情,,
     右按钮为退人进群
     /*!
     @method
     @brief 获取群组信息
     @param groupId 群组ID
     @param pError  错误信息
     @result 所获取的群组对象
     */
    
    /*
    - (EMGroup *)fetchGroupInfo:(NSString *)groupId error:(EMError **)pError;
    */
    
    NSLog(@"888%@",_emgroup.groupSubject);
    
#pragma mark --- UI配置
    
    self.groupImageV = [[TYQImageView alloc]initWithImage:[UIImage imageNamed:@"QQ.jpg"]];
    _groupImageV.frame = CGRectMake(0, 64, WIDTH, HEIGHT / 4);
    _groupImageV.backgroundColor = [UIColor redColor];
    _groupImageV.layer.cornerRadius = 5;
    _groupImageV.layer.masksToBounds = YES;
    [self.view addSubview:_groupImageV];
    
    
    self.groupIdLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(10, _groupImageV.frame.origin.y + _groupImageV.frame.size.height + 20, _groupImageV.frame.size.width - 20, HEIGHT / 14)];
    _groupIdLabel.backgroundColor = [UIColor whiteColor];
    _groupIdLabel.layer.cornerRadius = 25;
    _groupIdLabel.layer.masksToBounds = YES;
    _groupIdLabel.layer.borderWidth = 1;
    _groupIdLabel.textAlignment = NSTextAlignmentCenter;
    _groupIdLabel.textColor = [UIColor greenColor];
    _groupIdLabel.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:_groupIdLabel];
    _groupIdLabel.text = _emgroup.groupId;
    
    
    self.groupSubjectLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(_groupIdLabel.frame.origin.x, _groupIdLabel.frame.origin.y + _groupIdLabel.frame.size.height + 20, _groupIdLabel.frame.size.width, _groupIdLabel.frame.size.height)];
    _groupSubjectLabel.backgroundColor = [UIColor whiteColor];
    _groupSubjectLabel.layer.cornerRadius = 25;
    _groupSubjectLabel.layer.masksToBounds = YES;
     _groupSubjectLabel.layer.borderWidth = 1;
    _groupSubjectLabel.textAlignment = NSTextAlignmentCenter;
    _groupSubjectLabel.textColor = [UIColor greenColor];
    _groupSubjectLabel.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:_groupSubjectLabel];
    _groupSubjectLabel.text = _emgroup.groupSubject;
    
    //进入群聊按钮
    self.groupChatButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _groupChatButton.frame = CGRectMake(_groupIdLabel.frame.origin.x, _groupSubjectLabel.frame.origin.y + _groupSubjectLabel.frame.size.height + 40, _groupSubjectLabel.frame.size.width, _groupSubjectLabel.frame.size.height);
    _groupChatButton.backgroundColor = [UIColor greenColor];
    _groupChatButton.layer.cornerRadius = 25;
    _groupChatButton.layer.masksToBounds = YES;
    _groupChatButton.layer.borderWidth = 1;
    [_groupChatButton setTitle:@"进入群聊" forState:UIControlStateNormal];
    [self.view addSubview:_groupChatButton];
    [_groupChatButton addTarget:self action:@selector(groupChatButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
    // Do any additional setup after loading the view.
}


//左按钮
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)groupChatButtonAction:(UIButton *)button{
    
//    GroupChatViewController *groupVC = [[GroupChatViewController alloc] init];
    MessageChatViewController *groupVC = [[MessageChatViewController alloc] init];
    groupVC.titleName = _emgroup.groupId;
    
    groupVC.index = 2;
    
    [self.navigationController pushViewController:groupVC animated:YES];
    NSLog(@"进入群聊");
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
