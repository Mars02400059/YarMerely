//
//  RecomposePersonInfoViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/4.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "RecomposePersonInfoViewController.h"

@interface RecomposePersonInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;

@property (weak, nonatomic) IBOutlet UITextField *sexTextField;

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (weak, nonatomic) IBOutlet UITextField *autographTextField;


@end

@implementation RecomposePersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    // 添加playerName不是小明的约束条件
    [bquery whereKey:@"accountnumber" equalTo: [[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        BmobObject *object = array[0];
        
        _nicknameTextField.text = [object objectForKey:@"nickname"];
        _ageTextField.text = [object objectForKey:@"age"];
        _sexTextField.text = [object objectForKey:@"sex"];
        _autographTextField.text = [object objectForKey:@"autograph"];

    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)tapAction {
    [self.nicknameTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
    [self.sexTextField resignFirstResponder];
    [self.autographTextField resignFirstResponder];
}
- (IBAction)leftAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定修改信息吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //创建一个取消和一个确定按钮
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    UIAlertAction *ensureAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
        [bquery whereKey:@"accountnumber" equalTo: [[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            BmobObject *object = array[0];
            [object setObject:_nicknameTextField.text forKey:@"nickname"];
            [object setObject:_ageTextField.text forKey:@"age"];
            [object setObject:_sexTextField.text forKey:@"sex"];
            [object setObject:_autographTextField.text forKey:@"autograph"];
            //异步更新数据
            [object updateInBackground];
            
            
        }];
        
    }];
    //将取消和确定按钮添加进弹框控制器
    [alertController addAction:cancelAlert];
    [alertController addAction:ensureAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
    
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
