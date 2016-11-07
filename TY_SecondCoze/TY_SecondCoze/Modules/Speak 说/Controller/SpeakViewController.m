//
//  SpeakViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "SpeakViewController.h"
#import "SpeakAddViewController.h"


@interface SpeakViewController ()

@property (nonatomic, strong) TYQImageView *photoImageView;

@property (nonatomic, strong) TYQLabel *titleLabel;

@property (nonatomic, strong) TYQButton *sendButton;

@end

@implementation SpeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat Width = WIDTH - 10 * 2;
    self.photoImageView = [[TYQImageView alloc] initWithFrame:CGRectMake(10, 70, Width, Width)];
    [self.view addSubview:_photoImageView];
    
    self.titleLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(10, 70 + Width + 20, Width, 70)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_titleLabel];
    
    [self addNavigationBarView];
    self.navigationBarView.title = @"说";
    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"jia"];
    [self getSpeak];
    /// 刷新
    TYQButton *renovateButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    renovateButton.frame = CGRectMake(5, 20, 44, 44);
    [renovateButton setTitle:@"刷新" forState:UIControlStateNormal];
    [renovateButton addTarget:self action:@selector(renovateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renovateButton];

}
/// 获取一条说, 并且进行显示
- (void)getSpeak {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Speak"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            NSInteger index = arc4random() % array.count;
            BmobObject *object = array[index];
            _titleLabel.text = [object objectForKey:@"titleText"];
            BmobFile *file = (BmobFile*)[object objectForKey:@"imagePath"];
            [_photoImageView sd_setImageWithURL:[NSURL URLWithString:file.url]];
            NSLog(@"%@", file.url);
        }
    }];
}
/// 刷新说
- (void)renovateButtonAction {
    [self getSpeak];
}
- (void)tyq_navigationBarViewRightButtonAction {
    
    SpeakAddViewController *speakAddVC = [[SpeakAddViewController alloc] init];
    [self presentViewController:speakAddVC animated:YES completion:nil];
    
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
