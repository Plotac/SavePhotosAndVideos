//
//  SPStartUpOperationController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/5.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPStartUpOperationController.h"
#import "UITextField+DeleteBackward.h"

#define kDefaultPasswordNumberCount      4
#define kBorderMargin                    40

@interface SPStartUpOperationController ()<SPTextFieldDelegate>

@property (nonatomic,strong) NSMutableString *passwordStr;

@property (nonatomic,strong) UITextField *albumTF;

@end

@implementation SPStartUpOperationController

#pragma mark - Life Cycle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.passwordStr = [NSMutableString string];
    }
    return self;
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];

    switch (self.operationType) {
        case SPStartUpOperationSetLoginPW:{
            self.title = @"设置登录密码";
        }
            break;
        case SPStartUpOperationVerifyLoginPW:{
            self.title = @"验证登录密码";
        }
            break;
        case SPStartUpOperationVerifyAlbumPW:{
            self.title = @"验证相册密码";
        }
            break;
            
        default:
            break;
    }
    
    
    if (FingerprintRecognition.systemVersionSupport && FingerprintRecognition.deviceSupport && AppContext.needFingerprintRecognition) {
        [self fingerprintRecognition];
    }else {
        [self initViews];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - Notification
- (void)textFieldDidDeleteBackward:(UITextField *)textField {
    UITextField *tf = (UITextField*)[self.view viewWithTag:textField.tag - 1];
    if (tf) {
        [textField resignFirstResponder];
        
        tf.text = @"";
        [tf becomeFirstResponder];
        
        [self.passwordStr setString:@""];
        for (NSInteger i=0; i<kDefaultPasswordNumberCount; i++) {
            UITextField *txf = (UITextField*)[self.view viewWithTag:100 + i];
            if (txf.text.length > 0 && ![txf.text isEqualToString:@" "]) {
                [self.passwordStr appendString:txf.text];
            }
        }
    }
}

- (void)textFieldTextDidChange:(NSNotification*)notifi {
    
    if ([notifi.object isKindOfClass:[UITextField class]] && ![notifi.object isEqual:self.albumTF]) {//打开应用时的逻辑处理
        UITextField *tf = (UITextField*)notifi.object;
        if (tf.text.length == 1) {
            [self.passwordStr appendString:tf.text];
            [tf resignFirstResponder];
            tf = (UITextField*)[self.view viewWithTag:tf.tag + 1];
            if (tf) {
                [tf becomeFirstResponder];
            }else {
                
                switch (self.operationType) {
                    case SPStartUpOperationSetLoginPW:{
                        AppContext.loginPassword = self.passwordStr;
                    }
                        break;
                    case SPStartUpOperationVerifyLoginPW:{
                        if ([self.passwordStr isEqualToString:AppContext.loginPassword]) {
                            [self dismissViewControllerAnimated:YES completion:^{
                                if (self.dissmissBlock) {
                                    self.dissmissBlock(YES);
                                }
                            }];
                        }else {
                            
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录密码不正确！" message:nil preferredStyle: UIAlertControllerStyleAlert];
                            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                for (NSInteger i=0; i<kDefaultPasswordNumberCount; i++) {
                                    UITextField *textField = (UITextField*)[self.view viewWithTag:100 + i];
                                    textField.text = @"";
                                    if (i == 0) {
                                        [textField becomeFirstResponder];
                                    }
                                }
                                [self.passwordStr setString:@""];
                            }];
                            [alert addAction:action];
                            [self presentViewController:alert animated:YES completion:nil];
                        }
                    }
                        break;
                    default:
                        break;
                        
                }
            }
        }
    }else {//相册验证
        
    }
}

#pragma mark - Actions
- (void)cancelAction:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.dissmissBlock) {
            self.dissmissBlock(NO);
        }
    }];
}

- (void)verifyAction:(UIButton*)sender {
    BOOL success = NO;
    if ([[self.albumTF.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:self.album.password]) {
        success = YES;
    }
    if (success) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.dissmissBlock) {
                self.dissmissBlock(YES);
            }
        }];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码不正确！请重新输入" message:nil preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.albumTF.text = @"";
            [self.albumTF becomeFirstResponder];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - SPBaseViewControllerNavUIDelegate
- (NSArray<UIView*>*)leftNavBarItemCustomViews {
    if (self.operationType != SPStartUpOperationVerifyAlbumPW) {
        return nil;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromHexStr(@"#5893FB") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.frame = CGRectMake(0, 0, 50, 40);
    [btn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    return @[btn];
}

- (NSArray<UIView*>*)rightNavBarItemCustomViews {
    if (self.operationType != SPStartUpOperationVerifyAlbumPW) {
        return nil;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"验证" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromHexStr(@"#5893FB") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.frame = CGRectMake(0, 0, 50, 40);
    [btn addTarget:self action:@selector(verifyAction:) forControlEvents:UIControlEventTouchUpInside];
    return @[btn];
}

#pragma mark - Private
- (void)fingerprintRecognition {
    [FingerprintRecognition executeFingerprintRecognitionWithReason:@"请将手指轻放在Home键上验证指纹" state:^(BOOL success, NSInteger errorCode) {
        if (success) {//验证成功
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.dissmissBlock) {
                    self.dissmissBlock(YES);
                }
            }];
        }else {
            [self initViews];
//            switch (errorCode) {
//                case LAErrorAuthenticationFailed:{//验证失败
//                    [self initViews];
//                }
//                    break;
//                case LAErrorUserCancel:{//被用户手动取消
//                    [self initViews];
//                }
//                    break;
//                case LAErrorUserFallback:{//用户不使用TouchID,选择手动输入密码
//                    [self initViews];
//                }
//                    break;
//                case LAErrorSystemCancel:{//被系统取消 (如遇到来电,锁屏,按了Home键等)
//                }
//                    break;
//                case LAErrorPasscodeNotSet:{//无法启动,因为用户没有设置密码
//                }
//                    break;
//                case LAErrorTouchIDNotEnrolled:{//无法启动,因为用户没有设置TouchID
//                }
//                    break;
//                case LAErrorTouchIDNotAvailable:{//TouchID 无效
//                    [self initViews];
//                }
//                    break;
//                case LAErrorTouchIDLockout:{//TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)
//                }
//                    break;
//                case LAErrorAppCancel:{//当前软件被挂起并取消了授权 (如App进入了后台等)
//                }
//                    break;
//                case LAErrorInvalidContext:{//当前软件被挂起并取消了授权 (LAContext对象无效)
//                }
//                    break;
//                default:
//                    break;
//            }
        }
    }];
}

- (void)initViews {

    if (self.operationType == SPStartUpOperationVerifyAlbumPW) {
        self.albumTF = [UITextField JA_textFieldWithKeyboardType:UIKeyboardTypeASCIICapable superView:self.view constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight + kNavToolBarHeight + 80);
            make.left.equalTo(self.view).with.offset(kBorderMargin);
            make.right.equalTo(self.view).with.offset(-kBorderMargin);
            make.height.mas_equalTo(55);
        }];
        self.albumTF.font = kSystemFont(20);
        self.albumTF.layer.cornerRadius = 5;
        self.albumTF.clipsToBounds = YES;
        self.albumTF.backgroundColor = UIColor.whiteColor;
        self.albumTF.secureTextEntry = YES;
        self.albumTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 1, 7, 26)];
        self.albumTF.leftViewMode = UITextFieldViewModeAlways;
        self.albumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.albumTF becomeFirstResponder];
    }
    else {
        UITextField *tf = nil;
        for (NSInteger i=0; i<kDefaultPasswordNumberCount; i++) {
            
            tf = [UITextField JA_textFieldWithKeyboardType:UIKeyboardTypeNumberPad superView:self.view constraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(kStatusBarHeight + kNavToolBarHeight + 80);
                make.left.equalTo(self.view).with.offset(kBorderMargin + i *( 55 + (kScreenW - kBorderMargin*2 - 55*kDefaultPasswordNumberCount)/(kDefaultPasswordNumberCount-1) ));
                make.size.mas_equalTo(CGSizeMake(55, 55));
            }];
            tf.tag = 100 + i;
            tf.font = kSystemFont(20);
            tf.layer.cornerRadius = 5;
            tf.clipsToBounds = YES;
            tf.backgroundColor = UIColor.whiteColor;
            tf.textAlignment = NSTextAlignmentCenter;
            tf.delegate = self;
            tf.secureTextEntry = YES;
            if (i == 0) {
                [tf becomeFirstResponder];
            }
        }
    }

}

@end
