//
//  RegisterViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "RegisterViewController.h"
#import "HexColor.h"
#import "MyAPI.h"
#import "Tools.h"
#import "LoginViewController.h"
#import "UIViewController+HUD.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    BOOL IsSelected;
    NSTimer *timer;
    NSInteger time;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *testcode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (weak, nonatomic) IBOutlet UIButton *getcodebtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toplayout;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.phoneNum.delegate = self;
    //self.testcode.delegate =self;
    self.password.delegate = self;
    self.registerBtn.enabled = NO;
   // [self.getcodebtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.getcodebtn.layer.cornerRadius = 5;
    self.getcodebtn.clipsToBounds = YES;
    self.getcodebtn.font = [UIFont systemFontOfSize:11];
    self.getcodebtn.titleLabel.textColor = [UIColor blackColor];
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.clipsToBounds = YES;
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField

{
//    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y+textField.frame.size.height+216+50);
//    NSLog(@"offset == %f",offset);
//    if (offset<=0) {
    if(self.view.frame.size.height==480){
        [UIView animateWithDuration:0.3 animations:^{
            self.toplayout.constant = -30;
        }];
    }
//    }
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        self.toplayout.constant = 36;
    }];
    return YES;
}


- (IBAction)agreeDelegate:(id)sender {
    IsSelected = !IsSelected;
    if (IsSelected) {
        [sender setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
        self.registerBtn.enabled = YES;
    }else{
        [sender setImage:[UIImage imageNamed:@"slectdark"] forState:UIControlStateNormal];
        self.registerBtn.enabled = NO;
    }
}

- (IBAction)readDelegate:(id)sender {
    
    [self performSegueWithIdentifier:@"readSegue" sender:nil];
    
}


- (IBAction)Register:(id)sender {
   
    NSString * userpwd = self.password.text;
    NSString * SecurityPwd = [Tools loginPasswdSecurityLock:userpwd];
    NSString * phonenum = self.phoneNum.text;
    NSString * testcode = self.testcode.text;
    if(self.phoneNum.text.length<11){
        [self showHint:@"请输入正确的手机号"];
         return;
    }else if (self.password.text.length<6){
        [self showHint:@"请输入不少于6位的密码"];
        return;
    }
    [[MyAPI sharedAPI] RegistWithyzm:testcode password:SecurityPwd phoneNumber:phonenum result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
          
            [self showHint:@"注册成功，请登录"];
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            LoginViewController * VC = [storyboard instantiateViewControllerWithIdentifier:@"LOGIN"];
            [self  presentViewController:VC animated:YES completion:nil];
        }else{
            [self showHint:@"注册失败"];
            
        }
    } errorResult:^(NSError *enginerError) {
       
    }];
}

- (void)setTimeSchedu
{
    self.getcodebtn.enabled = NO;
    [self.getcodebtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.getcodebtn setTitle:@"60" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    time = 60;
    [timer fire];
    
}

- (void)timeAct:(id)sender
{
 
      if (time == 0) {
          [timer invalidate];
          self.getcodebtn.enabled = YES;
          [self.getcodebtn setBackgroundColor:[UIColor colorWithRed:251/255.0 green:150/255.0 blue:66/255.0 alpha:1]];
          [self.getcodebtn setTitle:@"发送验证码" forState:UIControlStateNormal];
      }else{
          time--;
          [self.getcodebtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
          [self.getcodebtn setBackgroundColor:[UIColor lightGrayColor]];
      }
      
  
    

}

- (IBAction)getTestWord:(UIButton*)sender {
    if (self.phoneNum.text.length < 11) {
        [self showHint:@"请输入正确的手机号"];
        return;
    }
     [self setTimeSchedu];//设置定时器
  //  __block int timeout = 60;
    NSString * phonenum = self.phoneNum.text;
    [[MyAPI sharedAPI] sendPhoneYZMWithphoneNumber:phonenum result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"验证码发送成功,请注意查看短信"];
        }else{
            time = 0;
            [self showHint:msg];
        }
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"验证码发送出错"];
    }];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    
//    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
//    
//    dispatch_source_set_event_handler(_timer, ^{
//        if (timeout<=0) {
//            dispatch_source_cancel(_timer);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [sender setImage:[UIImage imageNamed:@"getcode"] forState:UIControlStateNormal];
//                
//                sender.userInteractionEnabled = YES;
//                
//            });
//        }else{
//            int seconds = timeout&61;
//            
//            NSString * strTime = [NSString stringWithFormat:@"%2d",seconds];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [sender setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
//             //   [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//                
//                sender.backgroundColor = [UIColor grayColor];
//                sender.userInteractionEnabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
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
