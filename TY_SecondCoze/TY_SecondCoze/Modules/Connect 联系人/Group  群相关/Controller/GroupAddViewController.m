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
    _groupImageV.image = [UIImage imageNamed:@"群1"];
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
    _groupButton.frame = CGRectMake(20, HEIGHT / 3 * 2 , WIDTH - 40, 55);
    _groupButton.backgroundColor = [UIColor colorWithRed:0.39 green:0.78 blue:0.55 alpha:1.000];
    [_groupButton setTitle:@"立即创建" forState:UIControlStateNormal];
    _groupButton.layer.cornerRadius = 5;
    _groupButton.layer.masksToBounds = YES;
    [self.view addSubview:_groupButton];
    [_groupButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    self.navigationBarView.title = @"创建群";
    
    // Do any additional setup after loading the view.
}

#pragma mark --- 创建群

-(void) buttonAction:(UIButton *)button{
    
    EMError *error = nil;
    EMGroupStyleSetting *groupStyleSetting = [[EMGroupStyleSetting alloc] init];
    groupStyleSetting.groupMaxUsersCount = 500; // 创建500人的群，如果不设置，默认是200人。
    groupStyleSetting.groupStyle = eGroupStyle_PublicOpenJoin; // 创建不同类型的群组，这里需要才传入不同的类型
   
    EMGroup *group = [[EaseMob sharedInstance].chatManager createGroupWithSubject:self.groupTextFiled.text description:[NSString stringWithFormat:@"欢迎加入%@",self.groupTextFiled.text] invitees:@[] initialWelcomeMessage:@"邀请您加入群组" styleSetting:groupStyleSetting error:&error];
    if(!error){
       
        NSLog(@"-- 创建群成功 -- %@",group);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"创建群成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //在GameScore创建一条数据，如果当前没GameScore表，则会创建GameScore表
            BmobObject *gameScore = [BmobObject objectWithClassName:@"PersonInfo"];
            // 账号(群ID)
            [gameScore setObject:group.groupId forKey:@"accountnumber"];
            // 设置昵称(群名)
            [gameScore setObject:_groupTextFiled.text forKey:@"nickname"];
            // 设置age为18
            [gameScore setObject:@"我是群" forKey:@"age"];
            // 设置性别
            [gameScore setObject:@"我是群" forKey:@"sex"];
            // 设置签名
            [gameScore setObject:@"我是群" forKey:@"autograph"];
            UIImage *image = [UIImage imageNamed:@"群头像.jpg"];
            NSData *data = UIImagePNGRepresentation(image);;
            
            //图片保存的路径
            NSString * documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
            NSString *phonePath = [NSString stringWithFormat:@"/%@.png", _groupTextFiled.text];
            [fileManager createFileAtPath:[documentsPath stringByAppendingString:phonePath] contents:data attributes:nil];
            NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",documentsPath,  phonePath];
            NSLog(@"%@", filePath);
            BmobFile *file1 = [[BmobFile alloc] initWithFilePath:filePath];
            [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
                //如果文件保存成功，则把文件添加到filetype列
                if (isSuccessful) {
                    [gameScore setObject:file1  forKey:@"photoFile"];
                    //此处相当于新建一条记录,         //关联至已有的记录请使用 [obj updateInBackground];
                    [gameScore saveInBackground];
                    //打印file文件的url地址
                    NSLog(@"file1 url %@",file1.url);
                }else{
                    //进行处理
                }
            }];
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

//左按钮
-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}









@end
