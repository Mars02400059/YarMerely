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
