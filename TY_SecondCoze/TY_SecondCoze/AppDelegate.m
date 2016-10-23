//
//  AppDelegate.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/20.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainTabBarViewController.h"
#import "UserViewController.h"


@interface AppDelegate ()
// 注册登录用的协议
<
EMChatManagerDelegate
>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];

#pragma mark - 注册AppKey
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"1109161019115107#tenyar" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // 添加代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    
    // 引导页
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    // 判断是否第一次进入应用
    
    if (![userDef boolForKey:@"notFirst"]) {
        _window.rootViewController = [[ViewController alloc] init];
    } else {
    
        // 自动登录
//        BOOL isAutomatismLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
        
//        if (isAutomatismLogin == NO) {
            UserViewController *userViewController = [[UserViewController alloc] init];
            _window.rootViewController = userViewController;

//        } else {
            // 自动登录状态
            
//        }
    }

    return YES;
}


/*!
 @method
 @brief 用户自动登录完成后的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {
#warning 先将自动登录功能关掉, 否则影响后续开发
        // 自动登录制作完成
#if 0
    MainTabBarViewController *mainTabBarViewController = [[MainTabBarViewController alloc] init];
    self.window.rootViewController = mainTabBarViewController;
    
#endif
    
    

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    
}
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
    // 移除代理
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    
}

@end
