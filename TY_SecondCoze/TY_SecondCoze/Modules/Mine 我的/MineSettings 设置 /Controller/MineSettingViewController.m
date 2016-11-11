//
//  MineSettingViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/26.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineSettingViewController.h"
#import "MineSpaceTableViewCell.h"
#import "MineGrayBackTableViewCell.h"
#import "MineImageTableViewCell.h"
#import "UserViewController.h"
#import "MineInfoViewController.h"


static NSString *const spaceCell = @"spaceCell";
static NSString *const backCell = @"backCell";
static NSString *const imageCell = @"imageCell";



@interface MineSettingViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableViewArray;

#warning mark --- 设置夜间
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UILabel *cellLabel;//cell上铺的label

@end

@implementation MineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.000];
    [self addTableView];
    
    [self addNavigationBarView];
    self.navigationBarView.title = @"设置";
    self.navigationBarView.backColor.alpha = 1.f;
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
}

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 50 * 4 + 10) style:UITableViewStylePlain];
    _tableView.scrollEnabled = NO;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor clearColor];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineSpaceTableViewCell" bundle:nil] forCellReuseIdentifier:spaceCell];
    [_tableView registerNib:[UINib nibWithNibName:@"MineGrayBackTableViewCell" bundle:nil] forCellReuseIdentifier:backCell];
    [_tableView registerNib:[UINib nibWithNibName:@"MineImageTableViewCell" bundle:nil] forCellReuseIdentifier:imageCell];
    
    
    [self.view addSubview:_tableView];

}
- (NSArray *)tableViewArray {
    if (nil == _tableViewArray) {
        _tableViewArray = @[@"个人资料", @"夜间模式", @"", @"退出登录"];
    }
    return _tableViewArray;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _tableView.height = (self.tableViewArray.count - 1) * 50 + 10;
    return self.tableViewArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.tableViewArray.count - 2) {
        return 10.f;
    }
    return 50.f;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        MineImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell];
        cell.title = self.tableViewArray[indexPath.row];
        
        
        self.cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 30, 50)];
        cell.backgroundColor = [UIColor clearColor];
        //self.cellLabel.backgroundColor = [UIColor greenColor];
        self.cellLabel.textAlignment = NSTextAlignmentCenter;
        self.cellLabel.textColor = [UIColor colorWithRed:0 green:193 blue:207 alpha:1];
        [cell addSubview:self.cellLabel];
        
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:193 blue:207 alpha:1];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(WIDTH - 70, 10, 60, 30);
        [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        //self.button.backgroundColor = [UIColor colorWithRed:0 green:193 blue:207 alpha:1];
        
        self.imageV = [[UIImageView alloc] initWithFrame:self.button.bounds];
        [self.button addSubview:self.imageV];
        self.imageV.image = [UIImage imageNamed:@"ON"];
        self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [cell addSubview:self.button];
       
        return cell;
        
    }
    if (indexPath.row == 0) {
        
        MineImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell];
        cell.title = self.tableViewArray[indexPath.row];

        return cell;
    }
    
    else if (indexPath.row == self.tableViewArray.count - 1) {
        MineSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:spaceCell];
        cell.title = self.tableViewArray[indexPath.row];
        return cell;
    } else {
        MineGrayBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:backCell];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        MineInfoViewController *infoVC = [[MineInfoViewController alloc] init];
        infoVC.accountnumber = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    
    if (indexPath.row == self.tableViewArray.count - 1) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出登录吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //创建一个取消和一个确定按钮
        UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        //因为需要点击确定按钮后退出登录，所以需要在确定按钮这个block里面进行相应的操作
        UIAlertAction *ensureAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                if (!error) {
                    NSLog(@"退出成功");
                    UserViewController *userVC = [[UserViewController alloc] init];
                    [self presentViewController:userVC animated:YES completion:nil];
                }
            } onQueue:nil];
        
        }];
        //将取消和确定按钮添加进弹框控制器
        [alertController addAction:cancelAlert];
        [alertController addAction:ensureAlert];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
}


#pragma mark 点击事件

-(void)buttonAction:(UIButton *)button{
    
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        [self.dk_manager dawnComing];
        self.imageV.image = [UIImage imageNamed:@"ON"];

        NSLog(@"白天");
    }else{
        [self.dk_manager nightFalling];
        self.imageV.image = [UIImage imageNamed:@"OFF"];

        NSLog(@"黑天");
    }
    
}



- (void)tyq_navigationBarViewLeftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
