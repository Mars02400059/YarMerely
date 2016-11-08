//
//  MineViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/19.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MineViewController.h"
#import "MineSpaceTableViewCell.h"
#import "MineGrayBackTableViewCell.h"
#import "MineImageTableViewCell.h"
#import "MineSettingViewController.h"
#import "CropImageViewController.h"
#import "UIImage+FixOrientation.h"
#import "MineSpeakViewController.h"

static NSString *const spaceCell = @"spaceCell";
static NSString *const backCell = @"backCell";
static NSString *const imageCell = @"imageCell";

@interface MineViewController ()
<
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
/// 头视图
@property (nonatomic, strong) TYQView *headView;
/// 用户头像
@property (nonatomic, strong) TYQImageView *userHeadPortraits;
/// 用户名
@property (nonatomic, strong) TYQLabel *userNameLabel;
/// 头视图背景图片
@property (nonatomic, strong) TYQImageView *headBackImageView;
/// 头视图背景图片宽度
@property (nonatomic, assign) CGFloat headBackImageViewWidth;
/// 头视图背景图片高度
@property (nonatomic, assign) CGFloat headBackImageViewHeight;

@property (nonatomic, strong) NSArray *tableViewArray;
@property (nonatomic,strong)UIImagePickerController *Imgpicker;



@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {
    [_tableView reloadData];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    // 添加playerName不是小明的约束条件
    [bquery whereKey:@"accountnumber" equalTo:[[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            BmobObject *object = array[0];
            _userNameLabel.text = [object objectForKey:@"nickname"];
        }
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.000];
    
    [self addSubsView];

    
    [self addNavigationBarView];
    self.navigationBarView.backColor.alpha = 0.f;
    self.navigationBarView.rightButtonImage = [UIImage imageNamed:@"设置"];
}

- (void)addSubsView {
    
    self.headBackImageView = [[TYQImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    _headBackImageView.userInteractionEnabled = YES;
    _headBackImageView.frame = CGRectMake(0, 0, WIDTH, WIDTH * 0.7);
    self.headBackImageViewWidth = _headBackImageView.width;
    self.headBackImageViewHeight = _headBackImageView.height;
    [self.view addSubview:_headBackImageView];

    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [_tableView registerNib:[UINib nibWithNibName:@"MineSpaceTableViewCell" bundle:nil] forCellReuseIdentifier:spaceCell];
    [_tableView registerNib:[UINib nibWithNibName:@"MineGrayBackTableViewCell" bundle:nil] forCellReuseIdentifier:backCell];
    [_tableView registerNib:[UINib nibWithNibName:@"MineImageTableViewCell" bundle:nil] forCellReuseIdentifier:imageCell];

    
    [self.view addSubview:_tableView];

    
    
    self.headView = [[TYQView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 0.7)];
    _headView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _headView;
    
    self.userHeadPortraits = [[TYQImageView alloc] initWithFrame:CGRectMake((_headView.width - 80) / 2, _headView.height - 130, 80, 80)];
    _userHeadPortraits.userInteractionEnabled = YES;
    _userHeadPortraits.backgroundColor = [UIColor whiteColor];
    _userHeadPortraits.layer.cornerRadius = _userHeadPortraits.width / 2;
    _userHeadPortraits.clipsToBounds = YES;
    [_headView addSubview:_userHeadPortraits];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestAction)];
    tap.numberOfTapsRequired = 1;
    [_userHeadPortraits addGestureRecognizer:tap];
    
    
    self.userNameLabel = [[TYQLabel alloc] initWithFrame:CGRectMake(0, _headView.height - 35, WIDTH, 20)];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.font = [UIFont systemFontOfSize:19.f];
    _userNameLabel.textColor = [UIColor whiteColor];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    [_headView addSubview:_userNameLabel];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    [bquery whereKey:@"accountnumber" equalTo:[[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            BmobObject *object = array[0];
            _userNameLabel.text = [object objectForKey:@"nickname"];
            BmobFile *file = (BmobFile*)[object objectForKey:@"photoFile"];
            [_userHeadPortraits sd_setImageWithURL:[NSURL URLWithString:file.url]];
        }
    }];

}

- (void)tapGestAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更换头像" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name: @"CropOK" object: nil];
    UIAlertAction *photograph = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            return ;
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
        
    }];
    UIAlertAction *photoAlbum = [UIAlertAction actionWithTitle:@"从相册选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
        }];

    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:photoAlbum];
    [alert addAction:photograph];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

// 选择图像完成之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]];
    CropImageViewController *cropImg = [[CropImageViewController alloc] initWithCropImage:image];
    self.Imgpicker = picker;
    [picker presentViewController:cropImg animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmissPickerAction:) name:@"DISSMISSPICKER" object:nil];
    }];
    
    
}
- (void)dissmissPickerAction:(NSNotification *)notification{
    [self.Imgpicker dismissViewControllerAnimated:YES completion:nil];
}
- (void)notificationHandler: (NSNotification *)notification {
    _userHeadPortraits.image = notification.object;
    
    NSData *data = UIImagePNGRepresentation(notification.object);
    
    //图片保存的路径
    NSString * documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *phonePath = [NSString stringWithFormat:@"/%@.png", [[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
    [fileManager createFileAtPath:[documentsPath stringByAppendingString:phonePath] contents:data attributes:nil];
    NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",documentsPath,  phonePath];
    
    BmobFile *file1 = [[BmobFile alloc] initWithFilePath:filePath];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    // 添加playerName是当前的约束条件
    [bquery whereKey:@"accountnumber" equalTo:[[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            BmobObject *object = array[0];
            [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    // 关联至已有的记录请使用
                    [object setObject:file1  forKey:@"photoFile"];
                    [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (!error) {
                            
                        } else {
                            NSLog(@"草fuck");
                        }
                    }];
                } else {
                    NSLog(@"caocao草草草");
                }
            }];
        }
        
    }];
    
    
    
    
    
    
}


- (NSArray *)tableViewArray {
    if (nil == _tableViewArray) {
        _tableViewArray = @[@"", @"", @"设置", @"关于我们"];
    }
    return _tableViewArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (1 == indexPath.row) {
        return 10.f;
    }
    return 50.f;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (0 == indexPath.row) {
        MineSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:spaceCell];
        return cell;
    } else if (1 == indexPath.row) {
        MineGrayBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:backCell];
        return cell;
    } else {
        MineImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell];
        
        cell.title = self.tableViewArray[indexPath.row];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MineSpeakViewController *speakVC = [[MineSpeakViewController alloc] init];
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"Speak"];
        // 添加playerName不是小明的约束条件
        [bquery whereKey:@"accountnumber" equalTo:[[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            NSLog(@"%@", array);
            speakVC.tableViewArrray = array;
            speakVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:speakVC animated:YES];
        }];
        
    }
    if (indexPath.row == self.tableViewArray.count - 2) {
        MineSettingViewController *settingVC = [[MineSettingViewController alloc] init];
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    }
    
}

- (void)tyq_navigationBarViewRightButtonAction {
    MineSettingViewController *settingVC = [[MineSettingViewController alloc] init];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if (scrollView.contentOffset.y < 100) {
        self.navigationBarView.backColor.alpha = scrollView.contentOffset.y / 100;
        
    } else {
        self.navigationBarView.backColor.alpha = 1.f;
    }
    
    if (scrollView.contentOffset.y < 0) {
        
        CGFloat headImageViewHeight = _headBackImageViewHeight - scrollView.contentOffset.y;
        CGFloat headImageViewWidth = _headBackImageViewWidth * headImageViewHeight / _headBackImageViewHeight;
        CGFloat headImageViewX = (_headBackImageViewWidth - headImageViewWidth) / 2;
        CGFloat headImageViewY = 0;
        _headBackImageView.frame = CGRectMake(headImageViewX, headImageViewY, headImageViewWidth, headImageViewHeight);
        
    } else {
        
        CGFloat headImageViewY = -scrollView.contentOffset.y;
        _headBackImageView.frame = CGRectMake(0, headImageViewY, _headBackImageViewWidth, _headBackImageViewHeight);
    }

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
