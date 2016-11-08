//
//  MineSpeakViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/8.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineSpeakViewController.h"
#import "MIneSpeakTableViewCell.h"

@interface MineSpeakViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation MineSpeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[MIneSpeakTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
}

- (NSArray *)tableViewArrray {
    if (_tableViewArrray == nil) {
        
    }
    return _tableViewArrray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewArrray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MIneSpeakTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    BmobObject *object = _tableViewArrray[indexPath.row];
    cell.speakTextLabel.text = [object objectForKey:@"titleText"];
    BmobFile *file = [object objectForKey:@"imagePath"];
    [cell.speakImageView sd_setImageWithURL:[NSURL URLWithString:file.url]];
    
    return cell;
}

- (void)tyq_navigationBarViewLeftButtonAction {
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
