//
//  GroupDetailsViewController.m
//  TY_SecondCoze
//
//  Created by dllo on 16/11/2.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import <EMGroup.h>
#import <EMChatManagerGroupDelegate.h>
@interface GroupDetailsViewController ()

<
EMChatManagerDelegate
>
@end

@implementation GroupDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
//    NSLog(@"888%@",_emgroup.groupId);
    
    [self addNavigationBarView];
     self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    
   
    
    
    // Do any additional setup after loading the view.
}

-(void)tyq_navigationBarViewLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
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
