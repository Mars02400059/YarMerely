//
//  ViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/20.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "ViewController.h"
#import "UserViewController.h"
#import "MainTabBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    TYQLabel *label = [[TYQLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是引导页";
    [self.view addSubview:label];
    
    TYQButton *button = [TYQButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, self.view.width, 100);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"点我跳出引导页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)buttonAction:(TYQButton *)button {
    
    
    UserViewController *userViewController = [[UserViewController alloc] init];
    [self presentViewController:userViewController animated:YES completion:nil];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
