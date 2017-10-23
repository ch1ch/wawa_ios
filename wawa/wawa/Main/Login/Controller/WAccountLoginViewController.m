//
//  WAccountLoginViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/10/2.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WAccountLoginViewController.h"
#import <Toast/UIView+Toast.h>
#import "WMainViewController.h"
#import "AppDelegate.h"

@interface WAccountLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;



@end

@implementation WAccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _accountTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (IBAction)loginButtonEvent:(UIButton *)sender {
    
    if (_accountTextField.text.length < 6) {
        [self.view makeToast:@"请正确填写账号" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if (_passwordTextField.text.length < 6) {
        [self.view makeToast:@"请正确填写密码" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if ([_accountTextField.text isEqualToString:@"18201061223"] && [_passwordTextField.text isEqualToString:@"123456"]) {
        
        [self.view makeToast:@"登录成功！" duration:1 position:CSToastPositionCenter];
        
        WMainViewController *mainViewController = [[WMainViewController alloc]init];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainViewController];
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = nav;
    }
    else {
        
        [self.view makeToast:@"账号密码错误" duration:1 position:CSToastPositionCenter];
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.view.sd_y = - 260;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.view.sd_y = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
