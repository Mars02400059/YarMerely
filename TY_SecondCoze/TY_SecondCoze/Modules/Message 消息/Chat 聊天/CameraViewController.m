//
//  CameraViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/9.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()
//背景图片
@property (nonatomic, strong) TYQImageView *imageV;

//摄像头
@property (nonatomic, strong) TYQButton *webcamButton;


//挂断按钮
@property (nonatomic, strong) TYQButton *DRButton;

//静音按钮

@property (nonatomic, strong) TYQButton *muteButton;

//免提按钮
@property (nonatomic, strong) TYQButton *HandfreeButton;

//好友名字
@property (nonatomic, strong) TYQLabel *useNameLabel;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addUI];
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

#pragma maek --- 配置UI

-(void)addUI {
    
    //背景图片
    self.imageV = [[TYQImageView alloc] initWithImage:[UIImage imageNamed:@"callBg@2x"]];
    _imageV.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [self.view addSubview:_imageV];
    
    //切换摄像头
    self.webcamButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _webcamButton.backgroundColor = [UIColor redColor];
    _webcamButton.frame = CGRectMake(10, HEIGHT / 12, WIDTH / 5, WIDTH / 10);
    _webcamButton.font = [UIFont systemFontOfSize:15];
    [_webcamButton setTitle:@"切换摄像头" forState:UIControlStateNormal];
    [self.view addSubview:_webcamButton];
    
    //好友名
    self.useNameLabel = [TYQLabel new];
    _useNameLabel.frame = CGRectMake(WIDTH / 3, HEIGHT / 5, WIDTH / 3, _webcamButton.frame.size.height);
    _useNameLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_useNameLabel];
    
    //静音
    self.muteButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _muteButton.backgroundColor = [UIColor grayColor];
    _muteButton.frame = CGRectMake(WIDTH / 5, HEIGHT - HEIGHT / 3 , WIDTH / 2 / 3, WIDTH / 2 / 3);
    [_muteButton setImage:[UIImage imageNamed:@"静音"] forState:UIControlStateNormal];
    _muteButton.layer.cornerRadius = WIDTH / 2 / 3 / 2;
    _muteButton.layer.masksToBounds = YES;
    [self.view addSubview:_muteButton];
    
    //免提
    self.HandfreeButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _HandfreeButton.backgroundColor = [UIColor grayColor];
    _HandfreeButton.frame = CGRectMake(WIDTH - _muteButton.frame.size.width * 2, _muteButton.frame.origin.y, _muteButton.frame.size.width, _muteButton.frame.size.height);
    _HandfreeButton.layer.cornerRadius = WIDTH / 2 / 3 / 2;
    _HandfreeButton.layer.masksToBounds = YES;
    [_HandfreeButton setImage:[UIImage imageNamed:@"免提"] forState:UIControlStateNormal];
    [self.view addSubview:_HandfreeButton];
    
    //挂断
    self.DRButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _DRButton.backgroundColor = [UIColor greenColor];
    _DRButton.frame = CGRectMake(_useNameLabel.frame.origin.x, _HandfreeButton.frame.origin.y + _HandfreeButton.frame.size.height + 50 , _useNameLabel.frame.size.width, _useNameLabel.frame.size.height);
    [_DRButton setTitle:@"挂断" forState:UIControlStateNormal];
    [self.view addSubview:_DRButton];
    [_DRButton addTarget:self action:@selector(DRButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)DRButtonAction:(TYQButton *)button{

    NSLog(@"挂断");

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
