//
//  ReviseViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ReviseViewController.h"
#import "LoginViewController.h"
#import "UIViewController+HUD.h"
#import "Config.h"
#import "MyAPI.h"
#import "Tools.h"

@interface ReviseViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *revisePasswordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *reviseBtn;

@end

@implementation ReviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.reviseBtn.layer.cornerRadius = 5;
    self.reviseBtn.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reviseAction:(id)sender {
    
    if (self.oldPasswordField.text.length == 0 || self.revisePasswordField.text.length == 0 || self.confirmPasswordField.text.length == 0) {
        [self showHint:@"输入不能为空"];
        return;
    }
    
    if (!(self.revisePasswordField.text.length >= 6 && self.revisePasswordField.text.length <= 20)) {
        [self showHint:@"密码长度不符合要求"];
        return;
    }
    
    if (!(self.confirmPasswordField.text.length >= 6 && self.confirmPasswordField.text.length <= 20)) {
        [self showHint:@"密码长度不符合要求"];
        return;
    }
    if(![self.revisePasswordField.text isEqualToString:self.confirmPasswordField.text]){
        [self showHint:@"输入密码不一致"];
        return;
    }
    NSString * oldSecurityString = [Tools loginPasswdSecurityLock:self.oldPasswordField.text];
    NSString * newSecurityString = [Tools loginPasswdSecurityLock:self.revisePasswordField.text];
    //NSString * confirmSecurityString = [Tools loginPasswdSecurityLock:self.confirmPasswordField.text];
    //-  (void)modifyPwdWithOldPassword:(NSString *)oldpassword mpassword:(NSString*)mpassword repassword:(NSString *)repassword result:(StateBlock)result errorResult:(ErrorBlock)errorResult
    [[MyAPI sharedAPI] modifyPwdWithOldPassword:oldSecurityString mpassword:newSecurityString result:^(BOOL sucess, NSString *msg) {
    if(sucess){
        [self showHint:@"修改密码成功！"];
         [[Config Instance] logOut];
        [[Config Instance] saveUserPassword:newSecurityString];
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
         LoginViewController * vc = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"LOGIN"];
        vc.navigationController.navigationBar.hidden =NO;
      [UIApplication sharedApplication].keyWindow.rootViewController = vc;
       // LoginViewController * vc = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"LOGIN"];
        //[self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [self showHint:msg];
    }
    [self hideHud];
} errorResult:^(NSError *enginerError) {

}];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
