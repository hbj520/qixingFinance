//
//  LoginViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MyAPI.h"
#import "Tools.h"
#import "Marco.h"
#import "Config.h"
#import "UIViewController+HUD.h"
#import "PersonViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numberInput;
@property (weak, nonatomic) IBOutlet UITextField *codeInput;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)cancelBtn:(id)sender;
- (IBAction)backBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *TopDistance;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.numberInput.delegate = self;
    self.codeInput.delegate = self;
    [self.navigationItem setHidesBackButton:YES];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.clipsToBounds = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldIsEditing:) name:UITextFieldTextDidChangeNotification object:nil];

}

- (void)textfieldIsEditing:(NSNotification *)notification{
    
    if (self.numberInput.text.length >= 11) {
        //[self.loginBtn setImage:[UIImage imageNamed:@"login_ennablebtn"] forState:UIControlStateNormal];
        self.loginBtn.enabled = YES;
    }else{
       // [self.loginBtn setImage:[UIImage imageNamed:@"login_unablebtn"] forState:UIControlStateNormal];
        self.loginBtn.enabled = NO;
    }
}


- (IBAction)Login:(id)sender {
    NSString * phoneNum = self.numberInput.text;
    NSString * codeNum = self.codeInput.text;
    [Tools hideKeyBoard];
    if(phoneNum.length<11){
        [self showHint:@"请输入正确的手机号"];
        return;
    }else if (codeNum.length<6){
        [self showHint:@"请输入不少于6位的密码"];
        return;
    }
    
    NSString * securityString = [Tools  loginPasswdSecurityLock:codeNum];
    [self showHudInView:self.view hint:@"登录中..."];
    [[MyAPI sharedAPI] LoginWithNumber:phoneNum password:securityString result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [self showHint:@"登陆成功！"];
            [[Config Instance] saveUserPassword:securityString];
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [UIApplication sharedApplication].keyWindow.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];
        }else{
            [self showHint:msg];
        }
        [self hideHud];
        
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"登录出错"];
        [self hideHud];
    }];
    
 }

- (IBAction)Register:(id)sender {
    
       
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    [self.view endEditing:YES];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField

{
//    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y+textField.frame.size.height+216+50);
//    if (offset>=0) {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.top.constant = -offset;
//        }];
//    }

    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.top.constant = 41;
//    }];
    return YES;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (IBAction)cancelBtn:(id)sender {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
//        PersonViewController *VC = (PersonViewController *)[storyboard instantiateViewControllerWithIdentifier:@"personalId"];
//    [self presentViewController:VC animated:YES completion:nil];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
