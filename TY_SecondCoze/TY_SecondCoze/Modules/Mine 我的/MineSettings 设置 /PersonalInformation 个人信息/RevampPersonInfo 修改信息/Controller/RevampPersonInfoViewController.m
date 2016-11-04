//
//  RevampPersonInfoViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/3.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "RevampPersonInfoViewController.h"
#import "PersonInfoTextField.h"
#import "MinePersonInfoModel.h"

@interface RevampPersonInfoViewController ()
/// 昵称
@property (nonatomic, strong) PersonInfoTextField *nicknameTextField;
/// 性别
@property (nonatomic, strong) PersonInfoTextField *sexTextField;
/// 年龄
@property (nonatomic, strong) PersonInfoTextField *ageTextField;
/// 签名
@property (nonatomic, strong) PersonInfoTextField *autographTextField;



@end

@implementation RevampPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nicknameTextField = [[PersonInfoTextField alloc] initWithFrame:CGRectMake(50, 70, self.view.width - 50 * 2, 50)];
    _nicknameTextField.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
    _nicknameTextField.infoLabel.text = @"昵称";
    _nicknameTextField.infoTextField.text = _personModel.nickname;
    [self.view addSubview:_nicknameTextField];
    
    self.sexTextField = [[PersonInfoTextField alloc] initWithFrame:CGRectMake(50, 70 + 10 + 50, self.view.width - 50 * 2, 50)];
    _sexTextField.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
    _sexTextField.infoLabel.text = @"性别";
    _sexTextField.infoTextField.text = _personModel.sex;
    [self.view addSubview:_sexTextField];

    self.ageTextField = [[PersonInfoTextField alloc] initWithFrame:CGRectMake(50, 70 + 10 + 50 + 10 + 50, self.view.width - 50 * 2, 50)];
    _ageTextField.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
    _ageTextField.infoLabel.text = @"年龄";
    _ageTextField.infoTextField.text = _personModel.age;
    [self.view addSubview:_ageTextField];

    self.autographTextField = [[PersonInfoTextField alloc] initWithFrame:CGRectMake(50, 70 + 10 + 50 + 10 + 50 + 10 + 50, self.view.width - 50 * 2, 90)];
    _autographTextField.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
    _autographTextField.infoLabel.text = @"签名";
    _autographTextField.infoTextField.text = _personModel.autograph;
    [self.view addSubview:_autographTextField];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 70 + 10 + 50 + 10 + 50 + 10 + 50 + 150, self.view.width - 50 * 2, 40);
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"保存" forState:UIControlStateNormal];;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    [self.view addGestureRecognizer:gesture];

}

- (void)buttonAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定更改信息吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //创建一个取消和一个确定按钮
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    UIAlertAction *ensureAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
        // 添加playerName不是小明的约束条件
        [bquery whereKey:@"accountnumber" equalTo: [[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            
            //此处是更新操作
            BmobObject *gameScoreChanged =array[0];
            [gameScoreChanged setObject:_nicknameTextField.infoTextField.text forKey:@"nickname"];
            [gameScoreChanged setObject:_ageTextField.infoTextField.text forKey:@"age"];
            [gameScoreChanged setObject:_sexTextField.infoTextField.text forKey:@"sex"];
            [gameScoreChanged setObject:_autographTextField.infoTextField.text forKey:@"autograph"];
            [gameScoreChanged updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (!error) {
                    NSLog(@"更新成功，以下为对象值，可以看到json里面的name已经改变");
                    NSLog(@"%@",gameScoreChanged);
                } else {
                    NSLog(@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈又错了%@",error);
                }
            }];

        }];


        
    }];
    //将取消和确定按钮添加进弹框控制器
    [alertController addAction:cancelAlert];
    [alertController addAction:ensureAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)tyq_navigationBarViewLeftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

////点击空白处隐藏键盘方法
-(void)hideKeyboard{
    
    [_nicknameTextField.infoTextField resignFirstResponder];
    [_autographTextField.infoTextField resignFirstResponder];
    [_ageTextField.infoTextField resignFirstResponder];
    [_sexTextField.infoTextField resignFirstResponder];

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
