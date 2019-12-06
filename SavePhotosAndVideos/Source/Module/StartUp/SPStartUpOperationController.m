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
    
    self.title = self.operationType == SPStartUpOperationSetLoginPW ? @"设置登录密码" : @"验证登录密码";
    
    
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
    if ([notifi.object isKindOfClass:[UITextField class]]) {
        UITextField *tf = (UITextField*)notifi.object;
        if (tf.text.length == 1) {
            [self.passwordStr appendString:tf.text];
            NSLog(@"password : %@",self.passwordStr);
            [tf resignFirstResponder];
            tf = (UITextField*)[self.view viewWithTag:tf.tag + 1];
            if (tf) {
                [tf becomeFirstResponder];
            }else {
                if (self.operationType == SPStartUpOperationSetLoginPW) {
                    AppContext.loginPassword = self.passwordStr;
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else {
                    if ([self.passwordStr isEqualToString:AppContext.loginPassword]) {
                        [self dismissViewControllerAnimated:YES completion:nil];
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
            }
        }
    }
}

#pragma mark - Private
- (void)fingerprintRecognition {
    [FingerprintRecognition executeFingerprintRecognitionWithReason:@"请将手指轻放在Home键上验证指纹" state:^(BOOL success, NSInteger errorCode) {
        if (success) {//验证成功
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            switch (errorCode) {
                case LAErrorAuthenticationFailed:{//验证失败
                    [self initViews];
                }
                    break;
                case LAErrorUserCancel:{//被用户手动取消
                    [self initViews];
                }
                    break;
                case LAErrorUserFallback:{//用户不使用TouchID,选择手动输入密码
                    [self initViews];
                }
                    break;
                case LAErrorSystemCancel:{//被系统取消 (如遇到来电,锁屏,按了Home键等)
                }
                    break;
                case LAErrorPasscodeNotSet:{//无法启动,因为用户没有设置密码
                }
                    break;
                case LAErrorTouchIDNotEnrolled:{//无法启动,因为用户没有设置TouchID
                }
                    break;
                case LAErrorTouchIDNotAvailable:{//TouchID 无效
                    [self initViews];
                }
                    break;
                case LAErrorTouchIDLockout:{//TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)
                }
                    break;
                case LAErrorAppCancel:{//当前软件被挂起并取消了授权 (如App进入了后台等)
                }
                    break;
                case LAErrorInvalidContext:{//当前软件被挂起并取消了授权 (LAContext对象无效)
                }
                    break;
                default:
                    break;
            }
        }
    }];
}

- (void)initViews {

    for (NSInteger i=0; i<kDefaultPasswordNumberCount; i++) {
        
        UITextField *tf = [UITextField JA_textFieldWithKeyboardType:UIKeyboardTypeNumberPad superView:self.view constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight + kNavToolBarHeight + 80);
            make.left.equalTo(self.view).with.offset(kBorderMargin + i *( 55 + (kScreenW - kBorderMargin*2 - 55*kDefaultPasswordNumberCount)/(kDefaultPasswordNumberCount-1) ));
            make.size.mas_equalTo(CGSizeMake(55, 55));
        }];
        tf.tag = 100 + i;
        tf.layer.cornerRadius = 5;
        tf.clipsToBounds = YES;
        tf.backgroundColor = UIColor.whiteColor;
        tf.textAlignment = NSTextAlignmentCenter;
        tf.delegate = self;
        if (i == 0) {
            [tf becomeFirstResponder];
        }
    }
}

@end
