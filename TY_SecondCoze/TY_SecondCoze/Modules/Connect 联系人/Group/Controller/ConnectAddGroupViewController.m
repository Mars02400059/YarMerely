//
//  ConnectAddGroupViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/8.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "ConnectAddGroupViewController.h"
#import "MineImageTableViewCell.h"

@interface ConnectAddGroupViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>


@end

@implementation ConnectAddGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"MineImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    BmobObject *object = _tableViewArray[indexPath.row];
    BmobFile *file = [object objectForKey:@"photoFile"];
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:file.url]];
    cell.title = [object objectForKey:@"nickname"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认添加本群?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        BmobObject *object = _tableViewArray[indexPath.row];
        EMError *error = nil;
        // 申请加入需要审核的公开群组
        [[EaseMob sharedInstance].chatManager applyJoinPublicGroup:[object objectForKey:@"accountnumber"] withGroupname:[object objectForKey:@"nickname"] message:@"请求加入群组" error:&error];
        if (!error) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请已提交" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    [self.delegate tyq_dismiss];
                }];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)tyq_navigationBarViewLeftButtonAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
