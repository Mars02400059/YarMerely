//
//  MainTabBarViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "SpeakViewController.h"
#import "MessageViewController.h"
#import "ConnectViewController.h"
#import "MineViewController.h"
#import "TYQNavigationViewController.h"
#import "InfoModel.h"


@interface MainTabBarViewController ()
<
EMChatManagerDelegate,
EMChatManagerBuddyDelegate
>

// 存储好友申请的数组
@property (nonatomic, strong) NSMutableArray *sidekickAppleForArray;

@end

@implementation MainTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark--- 聊天管理器
    // 添加(聊天管理器)代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    self.sidekickAppleForArray = [NSMutableArray array];
    

#pragma mark --- 主动获取好友列表
    [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
    
}


#pragma mark --- 调取SDK的方法
- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message{
    
    InfoModel *infoModel = [[InfoModel alloc] init];
    infoModel.username = username;
    infoModel.message = message;
    
    [_sidekickAppleForArray addObject:infoModel];
}



#pragma mark --- 调取SDK接受好友请求方法(回调)
-(void)didAcceptedByBuddy:(NSString *)username{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ 接受了你的请求", username] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
//    InfoModel *infoModel = [[InfoModel alloc] init];
//     infoModel.username = username;
    
}
#pragma mark --- 调取SDK拒绝好友请求(回调)
- (void)didRejectedByBuddy:(NSString *)username{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ 拒绝了你的请求", username] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
//    InfoModel *infoModel = [[InfoModel alloc] init];
//    infoModel.username = username;

}

/*!
 @method
 @brief 收到加入群组的申请
 @param groupId         要加入的群组ID
 @param groupname       申请人的用户名
 @param username        申请人的昵称
 @param reason          申请理由
 @discussion
 */
#pragma mark --- 收到进群的申请
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error{
//    /*
//     谁谁谁(用户)申请加入该群
//     */
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定添加吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //创建一个取消和一个确定按钮
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[EaseMob sharedInstance].chatManager rejectApplyJoinGroup:groupId groupname:groupname toApplicant:username reason:@"拒绝原因"];
        
    }];
    
    UIAlertAction *ensureAlert = [UIAlertAction actionWithTitle:@"接受" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[EaseMob sharedInstance].chatManager acceptApplyJoinGroup:groupId groupname:groupname applicant:username error:nil];
        
    }];
    //将取消和确定按钮添加进弹框控制器
    [alertController addAction:cancelAlert];
    [alertController addAction:ensureAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (instancetype)init
{
    
    self = [super init];
    if (self) {
        
        SpeakViewController *speakViewController = [[SpeakViewController alloc] init];
        [self setViewController:speakViewController tabBarTitle:@"说" imageName:@"说1" selectedImageName:@"说2"];
        
        MessageViewController *messageViewController = [[MessageViewController alloc] init];
        [self setViewController:messageViewController tabBarTitle:@"消息" imageName:@"消息1" selectedImageName:@"消息2"];
        
        ConnectViewController *connectViewController = [[ConnectViewController alloc] init];
        connectViewController.infoArray = _sidekickAppleForArray;
        [self setViewController:connectViewController tabBarTitle:@"联系人" imageName:@"联系人1"  selectedImageName:@"联系人2"];
        
        MineViewController *mineViewController = [[MineViewController alloc] init];
        [self setViewController:mineViewController tabBarTitle:@"我的" imageName:@"我的1" selectedImageName:@"我的2"];
        
        
    }
    return self;
}

/// 设置视图, 并添加到容量视图控制器tabBar
- (void)setViewController:(TYQViewController *)viewController tabBarTitle:(NSString *)tabBarTitle imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    TYQNavigationViewController *navigationController = [[TYQNavigationViewController alloc] initWithRootViewController:viewController];
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:tabBarTitle image:image selectedImage:selectedImage];
    [self addChildViewController:navigationController];
    
    
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
