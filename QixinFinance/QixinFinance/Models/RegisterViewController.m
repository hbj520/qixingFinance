//
//  RegisterViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "RegisterViewController.h"
#import "MyAPI.h"
#import "UIViewController+HUD.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *testcode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (weak, nonatomic) IBOutlet UIButton *getcodebtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.getcodebtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.getcodebtn.font = [UIFont systemFontOfSize:11];
    self.getcodebtn.titleLabel.textColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldIsEditing:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - PrivateMethod
- (void)textfieldIsEditing:(NSNotification*)notification
{
//    if(self.nickname.text.length<5||self.phoneNum.text.length<11||self.password.text.length<6){
//        self.loginbtn.enabled = NO;
//    }else{
//        self.loginbtn.enabled = YES;
//    }

}


- (IBAction)Register:(id)sender {
   
    NSString * userpwd = self.password.text;
    NSString * phonenum = self.phoneNum.text;
    NSString * testcode = self.testcode.text;
    [[MyAPI sharedAPI] RegistWithyzm:testcode password:userpwd phoneNumber:phonenum result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            NSLog(@"注册成功");
            [self showHint:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHint:msg];
            
        }
    } errorResult:^(NSError *enginerError) {
        NSLog(@"%@",enginerError.localizedDescription);
    }];
}

- (IBAction)getTestWord:(UIButton*)sender {
    __block int timeout = 60;
    NSString * phonenum = self.phoneNum.text;
    [[MyAPI sharedAPI] sendPhoneYZMWithphoneNumber:phonenum result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:msg];
        }else{
            [self showHint:msg];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setImage:[UIImage imageNamed:@"getcode"] forState:UIControlStateNormal];
                
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout&61;
            
            NSString * strTime = [NSString stringWithFormat:@"%2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
             //   [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                
                sender.backgroundColor = [UIColor grayColor];
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)back:(id)sender {
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
