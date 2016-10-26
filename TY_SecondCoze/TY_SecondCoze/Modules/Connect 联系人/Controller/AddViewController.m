//
//  AddViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/10/26.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (nonatomic,strong) TYQTextField *textFiled;
@property (nonatomic, strong) TYQButton *nearbyButton;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
#pragma mark --- 创建添加联系人的配置(textfiled button)
    self.textFiled = [[TYQTextField alloc] init];
    self.textFiled.frame = CGRectMake(0, 80, WIDTH, 60);
    _textFiled.backgroundColor = [UIColor whiteColor];
    _textFiled.textAlignment = NSTextAlignmentCenter;
    _textFiled.placeholder = @"    🔍  请输入你要查找的号码";
    _textFiled.layer.cornerRadius = 2;
    _textFiled.layer.masksToBounds = YES;
    [self.view addSubview:_textFiled];
    
    self.nearbyButton = [TYQButton buttonWithType:0];
    _nearbyButton.frame = CGRectMake(0, _textFiled.frame.origin.y + _textFiled.frame.size.height + 20, WIDTH, 60);
    _nearbyButton.backgroundColor = [UIColor whiteColor];
    [_nearbyButton setImage:[UIImage imageNamed:@""] forState:0];
    [_nearbyButton setTitle:@"查看附近的人" forState:0];
    [_nearbyButton setTitleColor:[UIColor blackColor] forState:0];
    _nearbyButton.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:_nearbyButton];
    
    
    
    
#pragma mark --- 假导航上的按钮
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"jia"];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --- 左按钮方法
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark --- 右按钮实现添加好友功能
-(void)tyq_navigationBarViewRightButtonAction{
    NSLog(@"添加好友功能");
    
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
