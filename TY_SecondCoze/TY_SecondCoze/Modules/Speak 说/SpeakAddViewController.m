//
//  SpeakAddViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/11/7.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "SpeakAddViewController.h"

@interface SpeakAddViewController ()
<
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
@property (nonatomic, strong) TYQButton *imageButton;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UITextField *titleTextField;

@property (nonatomic, strong) TYQButton *sendButton;

@end

@implementation SpeakAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    self.imageButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _imageButton.frame = CGRectMake(20, 70, 110, 110);
    [_imageButton setImage:[UIImage imageNamed:@"icon_添加照片"] forState:UIControlStateNormal];
    [_imageButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imageButton];
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 70 + _imageButton.height + 10, self.view.width - 20 * 2, 60)];
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    _titleTextField.placeholder = @"请输入您要说的话";
    _titleTextField.layer.cornerRadius = 8.f;
    _titleTextField.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.000];
    _titleTextField.layer.borderColor = [UIColor grayColor].CGColor;
    _titleTextField.layer.borderWidth = 0.5;
    [self.view addSubview:_titleTextField];
    
    self.sendButton = [TYQButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(WIDTH - 49, 20, 44, 44);
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction {
    [self.titleTextField resignFirstResponder];
}

- (void)addButtonAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            return ;
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册中选取图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];

    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

// 选择图像完成之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *myimage = info[UIImagePickerControllerOriginalImage];
    self.image = [self compressImage:myimage toTargetWidth:480];
    [_imageButton setImage:_image forState:UIControlStateNormal];
    
}

- (void)sendButtonAction {
    
    if ([_titleTextField.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入您要说的话" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        if ([_imageButton.currentImage isEqual:[UIImage imageNamed:@"icon_添加照片"]]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择照片" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            // 上传一条说
            BmobObject *speak = [BmobObject objectWithClassName:@"Speak"];
            [speak setObject:[[EaseMob sharedInstance].chatManager loginInfo][@"username"] forKey:@"accountnumber"];
            [speak setObject:_titleTextField.text forKey:@"titleText"];
            NSData *data = UIImagePNGRepresentation(_image);
            //图片保存的路径
            NSString * documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
            NSString *phonePath = [NSString stringWithFormat:@"/%@.png", [[EaseMob sharedInstance].chatManager loginInfo][@"username"]];
            [fileManager createFileAtPath:[documentsPath stringByAppendingString:phonePath] contents:data attributes:nil];
            NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",documentsPath,  phonePath];
            NSLog(@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈%@", filePath);
            BmobFile *file1 = [[BmobFile alloc] initWithFilePath:filePath];
            [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
                //如果文件保存成功，则把文件添加到filetype列
                if (isSuccessful) {
                    [speak setObject:file1  forKey:@"imagePath"];
                    [speak saveInBackground];
                    
                    
                } else {
                    //进行处理
                    NSLog(@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈%@", error);
                }
            }];
            
            [self.titleTextField resignFirstResponder];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }

}

/// 压缩图片尺寸
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (void)tyq_navigationBarViewLeftButtonAction {
    [self.titleTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
