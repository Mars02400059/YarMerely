//
//  TYQViewController.m
//  Tenyar
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "TYQViewController.h"

@interface TYQViewController ()

@end

@implementation TYQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xFFFFFF,0xC1CDCD);
    
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);


    
    
}

- (void)addNavigationBarView {

    self.navigationBarView = [[TYQNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    _navigationBarView.delegate = self;
    self.navigationBarView.backColor.backgroundColor = [UIColor colorWithRed:0.35 green:0.80 blue:0.98 alpha:1.00];
    [self.view addSubview:_navigationBarView];
}

- (void)tyq_navigationBarViewLeftButtonAction {
    
}

- (void)tyq_navigationBarViewRightButtonAction {
    
}


//通知方法
//notification参数保存着通知传递多来的参数值
//NSNotification该类里有object属性专门是保存参数值的,因此参数类型需要写成NSNotification类
//因为NSNotificationCenter类没有object属性,就拿不到值
//- (void)night:(NSNotification *)night{
//    self.view.backgroundColor =  PQRGBA(181, 181, 181, 1);
//    self.navigationController.navigationBar.barTintColor =   PQRGBA(54, 54, 54, 1);
//    self.tabBarController.tabBar.barTintColor =   PQRGBA(54, 54, 54, 1);
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isNight"];
//    
//    
//}
- (void)day:(NSNotification *)day{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:135 / 255.0 green:180 / 255.0 blue:229 / 255.0 alpha:1];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:135 / 255.0 green:180 / 255.0 blue:229 / 255.0 alpha:0.7];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isNight"];
    
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
