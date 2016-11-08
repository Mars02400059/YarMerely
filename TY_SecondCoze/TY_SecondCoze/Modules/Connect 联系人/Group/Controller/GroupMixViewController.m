//
//  GroupMixViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/3.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupMixViewController.h"
#import "ConnectAddGroupViewController.h"

@interface GroupMixViewController ()
<
ConnectAddGroupViewControllerDelegate
>
@property (nonatomic, strong) TYQTextField *nameFiled;
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

    
    self.nameFiled = [[TYQTextField alloc] init];
    _nameFiled.frame = CGRectMake(20, 80, WIDTH - 20 * 2, 45);
    _nameFiled.backgroundColor = [UIColor whiteColor];
    _nameFiled.layer.borderWidth = 1;
    _nameFiled.layer.cornerRadius = 5;
    _nameFiled.layer.masksToBounds = YES;
    _nameFiled.textAlignment = NSTextAlignmentCenter;
    _nameFiled.placeholder = @"请输入群名称";
    [self.view addSubview:_nameFiled];
    

    self.applyButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _applyButton.frame = CGRectMake(20, HEIGHT / 2, WIDTH - 40, 55);
    _applyButton.backgroundColor = [UIColor colorWithRed:0.39 green:0.78 blue:0.55 alpha:1.000];
    _applyButton.layer.cornerRadius = 5;
    _applyButton.layer.masksToBounds = YES;
    [_applyButton setTitle:@"搜索" forState:UIControlStateNormal];
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
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    // 添加playerName不是小明的约束条件
    [bquery whereKey:@"nickname" equalTo:self.nameFiled.text];
    [bquery whereKey:@"sex" equalTo:@"我是群"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            
            ConnectAddGroupViewController *connectAddGroupVC = [[ConnectAddGroupViewController alloc] init];
            connectAddGroupVC.delegate = self;
            connectAddGroupVC.tableViewArray = array;
            [self presentViewController:connectAddGroupVC animated:YES completion:^{
                
            }];
            
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"没有这样的一个群" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
    }];
    
}

- (void)tyq_dismiss {
    [self.navigationController popViewControllerAnimated:YES];
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
