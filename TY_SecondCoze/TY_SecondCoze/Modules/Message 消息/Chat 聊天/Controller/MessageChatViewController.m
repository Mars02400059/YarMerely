//
//  MessageChatViewController.m
//  TY_SecondCoze
//
//  Created by mars on 16/10/27.
//  Copyright © 2016年 TengYa. All rights reserved.
//

#import "MessageChatViewController.h"
#import "StationView.h"
#import "MessageChatTableViewCell.h"
#import "MessageChatConversationModel.h"
#import "Tools.h"
#import "MoreFunctionView.h"
#import "PhoneView.h"
#import "EMCDDeviceManager.h"
#import "RealtimeCallViewController.h"
#import "ViewController.h"
#import "EmojiView.h"
#import "CameraViewController.h"

#import "CallViewController.h"


// 操作台的高度
static CGFloat const stationViewHeight = 60.f;

static NSString *const Cell = @"cell";

@interface MessageChatViewController ()
<
MessageChatTableViewCellDelegate,
PhoneViewDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
MoreFunctionViewDelegate,
StationViewDelegate,
EMChatManagerDelegate,
EMCallManagerDelegate,
UITableViewDelegate,
UITableViewDataSource,
doIt
>
// 消息tableView
@property (nonatomic, strong) UITableView *messageTableView;
// 控制台, (语音, 文字输入, 表情....)
@property (nonatomic, strong) StationView *stationView;
// 存消息的数组
@property (nonatomic, strong) NSMutableArray *messageArray;
// 单个cell高度
@property (nonatomic, assign) CGFloat cellHeight;
// cell总高度
@property (nonatomic, assign) CGFloat tableViewCellHeightSum;
// 键盘高度
@property (nonatomic, assign) CGFloat keyboardHeight;
// 记录cell
@property (nonatomic, assign) NSInteger number;
/// 更多功能
@property (nonatomic, strong) MoreFunctionView *moreFunctionView;
/// 语音功能
@property (nonatomic, strong) PhoneView *phoneView;

//表情功能
@property (nonatomic, strong) EmojiView *emojiView;


@end

@implementation MessageChatViewController

- (void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].callManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者

}

- (void)viewWillAppear:(BOOL)animated {
    [self didUnreadMessagesCountChanged];
//    [self ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.number = 0;
    // 聊天管理器
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];

    self.messageArray = [NSMutableArray array];
    
    [self addTableView];
    [self addstationView];
    [self addMoreFunctionView];
    [self addPhoneView];
    [self addEmojiView];
    [self addNavigationBarView];
    self.navigationBarView.leftButtonImage = [UIImage imageNamed:@"返回"];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"PersonInfo"];
    // 添加playerName不是小明的约束条件
    [bquery whereKey:@"accountnumber" equalTo:_titleName];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            BmobObject *object = array[0];
            self.navigationBarView.title = [object objectForKey:@"nickname"];
        }
    }];
    
}



- (void)addTableView {

    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - stationViewHeight) style:UITableViewStylePlain];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [_messageTableView registerClass:[MessageChatTableViewCell class] forCellReuseIdentifier:Cell];
    [self.view addSubview:_messageTableView];
}

- (void)addstationView {
    self.stationView = [[StationView alloc] initWithFrame:CGRectMake(0, self.view.height - stationViewHeight, self.view.width, stationViewHeight)];
    _stationView.delegate = self;
    _stationView.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
    _stationView.layer.borderColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.000].CGColor;
    _stationView.layer.borderWidth = 1.f;
    [self.view addSubview:_stationView];
    
  
#warning mark ---

    
    // 键盘监听
    // 键盘将要出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tyq_KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    // 键盘将要消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tyq_KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tyq_HideKeyboard)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    [self.messageTableView addGestureRecognizer:gesture];

}
- (void)addMoreFunctionView {
    
    self.moreFunctionView = [[MoreFunctionView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, WIDTH / 2)];
    _moreFunctionView.delegate = self;
    _moreFunctionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self.view addSubview:_moreFunctionView];
    
}

- (void)addPhoneView {
    self.phoneView = [[PhoneView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, WIDTH / 2)];
    _phoneView.delegate = self;
    [self.view addSubview:_phoneView];
}

-(void)addEmojiView {
    
    self.emojiView = [[EmojiView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 210)];
    _emojiView.backgroundColor = [UIColor clearColor];
    _emojiView.delegate = self;
    [self.view addSubview:_emojiView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MessageChatConversationModel *chatModel = _messageArray[indexPath.row];
    
    
    switch (chatModel.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            
            CGFloat bubbleHeight;
            CGFloat border = 15.f;
            CGFloat bubbleTextWidthMax = WIDTH - (10 * 2 + 50) * 2 - border * 2;
            
            CGFloat bubbleTextHeight;
            CGFloat textWidth = [Tools getTextWidth:chatModel.textMessage withFontSize:20.f];
            if (textWidth < bubbleTextWidthMax) {
                bubbleTextHeight = 22.f;
            } else {
                CGFloat textHeight = [Tools getTextHeight:chatModel.textMessage withWidth:bubbleTextWidthMax withFontSize:20];
                bubbleTextHeight = textHeight;
            }
            bubbleHeight = bubbleTextHeight + border * 2;
            
            
            self.cellHeight = bubbleHeight + 10.f * 2 + 15;
            
            if (_number == indexPath.row) {
                self.tableViewCellHeightSum += _cellHeight;
                _number++;
            }
            
        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            
            self.cellHeight = chatModel.imageSize.height + 10.f * 2 + 15;
            
            if (_number == indexPath.row) {
                self.tableViewCellHeightSum += _cellHeight;
                _number++;
            }
            
        }
            break;
        case eMessageBodyType_Location:
        {
            // 经纬度
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频
            self.cellHeight = 50.f + 10.f * 2 + 15;
            
            if (_number == indexPath.row) {
                self.tableViewCellHeightSum += _cellHeight;
                _number++;
            }
        }
            break;
        case eMessageBodyType_Video:
        {
            // 视频
            
        }
            break;
        case eMessageBodyType_File:
        {
            // 文件
        }
            break;
            
        default:
            break;
    }
    


    return _cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MessageChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    MessageChatTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MessageChatTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Cell];
    }

    cell.index = _index;

    cell.delegate = self;
    cell.chatModel = _messageArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
// 点击气泡的协议方法

- (void)tyq_bubbleTapGestureRecognizerTableViewCell:(MessageChatTableViewCell *)messageChatTableViewCell {
    switch (messageChatTableViewCell.chatModel.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            
        }
            break;
        case eMessageBodyType_Location:
        {
            // 经纬度
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频SDK会自动下载
            UIButton *contentButton = (UIButton *)messageChatTableViewCell.backgroundView;
            
            if ([[EMCDDeviceManager sharedInstance] isPlaying]) {
                [[EMCDDeviceManager sharedInstance] stopPlaying];
                [contentButton.imageView stopAnimating];
            } else {
                [contentButton.imageView startAnimating];
                [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:messageChatTableViewCell.chatModel.voicePath completion:^(NSError *error) {
                    //
                    if (!error) {
                        //
                        [contentButton.imageView stopAnimating];
                    }
                }];
                
            }
        }
            break;
        case eMessageBodyType_Video:
        {
            // 视频
            
        }
            break;
        case eMessageBodyType_File:
        {
            // 文件
        }
            break;
            
        default:
            break;
    }
    

}

// 改变tableView 偏移量的方法
- (void)tyq_tableViewContentOffsetY {
    // 设置偏移量, 使最后一条消息显示在底部
    if (_tableViewCellHeightSum > _messageTableView.height) {
        _messageTableView.contentOffset = CGPointMake(0, _tableViewCellHeightSum - _messageTableView.height);

    }

}

// 未读消息数改变的回调
- (void)didUnreadMessagesCountChanged {
    [self tyq_getconversation];
    
    [self tyq_tableViewContentOffsetY];
}


#pragma mark - 接受消息
// 获取会话
- (void)tyq_getconversation {
    [_messageArray removeAllObjects];
    
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:_titleName conversationType:eConversationTypeChat];
    
    // 消息id加载消息
#warning 消息ID怎么取???
    NSArray *messageArray = [conversation loadNumbersOfMessages:100 withMessageId:nil];
    
    for (EMMessage *message in messageArray) {
        MessageChatConversationModel *messageModel = [[MessageChatConversationModel alloc] init];
        messageModel.message = message;
        [_messageArray addObject:messageModel];
    }
    
    [_messageTableView reloadData];

    
    // 最后一个参数  把本对话里的所有消息标记为已读/未读
    [[[EaseMob sharedInstance].chatManager conversationForChatter:_titleName conversationType:eConversationTypeChat] markAllMessagesAsRead:YES];
    
}

#warning 有时间将键盘变化改成动画
#pragma mark - 键盘相关
// 键盘将要出现
- (void)tyq_KeyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    CGRect endFrame = [userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 结束变化时的键盘高
    self.keyboardHeight = endFrame.size.height;
    _messageTableView.height = HEIGHT - stationViewHeight - _keyboardHeight - 64;
    
    _stationView.y = HEIGHT - _keyboardHeight - stationViewHeight;

    [self tyq_tableViewContentOffsetY];
    [_stationView tyq_allButtonRecordReduction];
    _moreFunctionView.y = HEIGHT;
    _phoneView.y = HEIGHT;
}
// 键盘将要消失
- (void)tyq_KeyboardWillHide:(NSNotification *)notification {
    
    _messageTableView.height = HEIGHT - stationViewHeight - 64;
    
    _stationView.y = HEIGHT - stationViewHeight;
    
    [self tyq_tableViewContentOffsetY];
//    [_stationView tyq_allButtonRecordReduction];
    _moreFunctionView.y = HEIGHT;
}
// 隐藏键盘
- (void)tyq_HideKeyboard {
    [_stationView.importTextField resignFirstResponder];
}

- (void)tyq_navigationBarViewLeftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  发送一条文本消息

// 点击加号按钮后传递出来的协议方法
- (void)tyq_butttonClickSendMessageDelegate:(BOOL)record {
    if (record) {
        [self tyq_HideKeyboard];
        _phoneView.y = HEIGHT;
        _moreFunctionView.y = HEIGHT - _moreFunctionView.height;
        _stationView.y = HEIGHT - _moreFunctionView.height - stationViewHeight;
        _messageTableView.height = HEIGHT - _moreFunctionView.height - stationViewHeight - 64;
        [self tyq_tableViewContentOffsetY];
    } else {
        _moreFunctionView.y = HEIGHT;
        [_stationView.importTextField becomeFirstResponder];
        [_stationView tyq_allButtonRecordReduction];
    }
}
// 点击表情按钮
- (void)tyq_expressionDelegate:(BOOL)record {
    if (record) {
        
        [self tyq_HideKeyboard];
        _moreFunctionView.y = HEIGHT;
        _emojiView.y = HEIGHT - _emojiView.height;
        _stationView.y = HEIGHT - _emojiView.height - stationViewHeight;
        _messageTableView.height = HEIGHT - _emojiView.height - stationViewHeight - 64;
        [self tyq_tableViewContentOffsetY];
        
    } else {
      
        _emojiView.y = HEIGHT;
        [_stationView.importTextField becomeFirstResponder];
        [_stationView tyq_allButtonRecordReduction];

//        NSLog(@"fghjkl");
    }
}
// 点击语音按钮
- (void)tyq_phoneFunctionDelegate:(BOOL)record {
    if (record) {
        [self tyq_HideKeyboard];
        _moreFunctionView.y = HEIGHT;
        _phoneView.y = HEIGHT - _phoneView.height;
        _stationView.y = HEIGHT - _phoneView.height - stationViewHeight;
        _messageTableView.height = HEIGHT - _phoneView.height - stationViewHeight - 64;
        [self tyq_tableViewContentOffsetY];
 
    } else {
        _phoneView.y = HEIGHT;
        [_stationView.importTextField becomeFirstResponder];
        [_stationView tyq_allButtonRecordReduction];
    }
}
/// 点击按住说话
- (void)tyq_touchesBegan {
    
    [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:_titleName completion:^(NSError *error) {
        if (!error) {
            NSLog(@"正在录制");
        }
    }];
}
/// 松开按钮
- (void)tyq_touchesEnded {
    
    [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        if (!error) {
            EMChatVoice *voice = [[EMChatVoice alloc] initWithFile:recordPath displayName:@"audio"];
            // 录音时长
            voice.duration = aDuration;
            EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithChatObject:voice];
            
            // 生成message
            EMMessage *message = [[EMMessage alloc] initWithReceiver:_titleName bodies:@[body]];
            
            if (_index == 1) {
                message.messageType = eMessageTypeChat; // 设置为单聊消息
            }
            if (_index == 2) {
                message.messageType = eMessageTypeGroupChat; // 设置为群聊消息
            }
            [self tyq_messageSend:message];

            
        }
    }];
    
}

// 点击添加图片
- (void)tyq_addPhotoActionDelegate {
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    [self presentViewController:imagePickerController animated:YES completion:nil];
    NSLog(@"相册");
}

// 选取图片, 发送图片消息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    EMChatImage *imgChat = [[EMChatImage alloc] initWithUIImage:image displayName:@"嘿嘿嘿"];
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithChatObject:imgChat];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithReceiver:_titleName bodies:@[body]];
    if (_index == 1) {
        message.messageType = eMessageTypeChat; // 设置为单聊消息
    }
    if (_index == 2) {
        message.messageType = eMessageTypeGroupChat; // 设置为群聊消息
    }
    [self tyq_messageSend:message];
}
/// 点击语音通话
- (void)tyq_addVoiceActionDelegate {
//    RealtimeCallViewController *realtimeCallVC = [[RealtimeCallViewController alloc] init];
//    
//    [self presentViewController:realtimeCallVC animated:YES completion:nil];
    
    NSLog(@"语音");
    
}
/// 点击视频通话
- (void)tyq_addVideoActionDelegate {
 

    BOOL isopen = [self canVideo];
    EMError *error = nil;
    EMCallSession *callSession = nil;
    if (!isopen) {
        NSLog(@"不能打开视频");
        return ;
    }
    //这里发送视频请求                                                       //userName
    callSession = [[EaseMob sharedInstance].callManager asyncMakeVideoCall:@"用户名" timeout:50 error:&error];
    //请求完以后,开始做下面的
    if (callSession && !error) {
        
        [[EaseMob sharedInstance].callManager removeDelegate:self];
        
        CallViewController *callController = [[CallViewController alloc] initWithSession:callSession isIncoming:NO];
        callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:callController animated:NO completion:nil];
        
        
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", @"error") message:error.description delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    NSLog(@"视频按钮");

}


#warning mark --- 点击视频按钮(跳转到CallViewController)

- (void)tyq_addcameraActionDelegate {
    



        NSLog(@"照相的相机");

}
- (void)tyq_addcameraActionDelegate {
    
    CameraViewController *cameraVC = [[CameraViewController alloc] init];
    
    
    [self.navigationController pushViewController:cameraVC animated:YES];

    NSLog(@"视频按钮");
}


//点击return按钮所做的动作：

- (void)tyq_actionTextFieldReturn {
    /*!
     @method
     @brief 以字符串构造文本对象
     @discussion
     @param text 文本内容
     @result 文本对象
     */
    EMChatText *txtChat = [[EMChatText alloc] initWithText:_stationView.importTextField.text];
    /*!
     @method
     @brief 以文本对象创建文本消息体实例
     @discussion
     @param aChatText 文本对象
     @result 文本消息体
     */
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
    
    /*!
     @method
     @brief 创建消息实例（用于:创建一个新的消息）
     @discussion 消息实例会在发送过程中内部状态发生更改,比如deliveryState
     @param receiver 消息接收方
     @param bodies 消息体列表
     @result 消息实例
     */
    // 生成message
    
    EMMessage *message = [[EMMessage alloc] initWithReceiver:_titleName bodies:@[body]];
    if (_index == 1) {
        message.messageType = eMessageTypeChat; // 设置为单聊消息
    }
    if (_index == 2) {
        message.messageType = eMessageTypeGroupChat; // 设置为群聊消息
    }
    [self tyq_messageSend:message];
    

}

// 消息发送
- (void)tyq_messageSend:(EMMessage *)message {
    message.deliveryState = eMessageDeliveryState_Delivered;
    [self tyq_getconversation];
    
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
        //
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        //
        if (!error) {
            
            [self tyq_getconversation];
        }
    } onQueue:nil];
    if (_stationView.importTextField.text.length > 0) {
        _stationView.importTextField.text = @"";
    }
}



//代理人执行方法

-(void)doSomething:(NSString *)string{
    
    _stationView.importTextField.text = string;
    
}



#pragma mar]k --- 判断是否打开相机(视频相机)
-(BOOL)canVideo{
    BOOL canvideo = YES;
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    NSLog(@"---cui--authStatus--------%ld",(long)authStatus);
    // This status is normally not visible—the AVCaptureDevice class methods for discovering devices do not return devices the user is restricted from accessing.
    if(authStatus ==AVAuthorizationStatusRestricted){//此应用程序没有被授权访问的照片数据。可能是家长控制权限。
        NSLog(@"Restricted");
        canvideo = NO;
        return canvideo;
    }else if(authStatus == AVAuthorizationStatusDenied){//用户已经明确否认了这一照片数据的应用程序访问.
        // The user has explicitly denied permission for media capture.
        NSLog(@"Denied");     //应该是这个，如果不允许的话
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在设备的\"设置-隐私-相机\"中允许访问相机。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        alert = nil;
        canvideo = NO;
        return canvideo;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问,用户已授权应用访问照片数据.
        // The user has explicitly granted permission for media capture, or explicit user permission is not necessary for the media type in question.
        NSLog(@"Authorized");
        canvideo = YES;
        return canvideo;
    }else if(authStatus == AVAuthorizationStatusNotDetermined){//用户尚未做出了选择这个应用程序的问候
        // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {//请求访问照相功能.
            //应该在打开视频前就访问照相功能,不然下面返回不了值啊.
            if(granted){//点击允许访问时调用
                //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                NSLog(@"Granted access to %@", mediaType);
                
            }
            else {
                NSLog(@"Not granted access to %@", mediaType);
            }
        }];
    }else {
        NSLog(@"Unknown authorization status");
        canvideo = NO;
    }
    return canvideo;
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
