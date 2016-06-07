//
//  LoginViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LoginViewController.h"
#import "MyAPI.h"
#import "Tools.h"
#import "Marco.h"
#import "Config.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numberInput;
@property (weak, nonatomic) IBOutlet UITextField *codeInput;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSString * securityString = [Tools  loginPasswordSecurityLock:codeNum];
   
    [[MyAPI sharedAPI] LoginWithNumber:phoneNum password:codeNum result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [[Config Instance] saveUserPassword:securityString];
            NSLog(@"成功");
             [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"%@",msg);
        }
        
        
    } errorResult:^(NSError *enginerError) {
        NSLog(@"%@",enginerError.localizedDescription);
    }];
    
 }

- (IBAction)Register:(id)sender {
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    [self.view endEditing:YES];
    
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

@end
