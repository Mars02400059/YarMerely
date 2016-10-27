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



@interface MainTabBarViewController ()
//<
//EMChatManagerDelegate
//>

@end

@implementation MainTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 聊天管理器
//    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
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
