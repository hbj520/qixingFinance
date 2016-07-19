//
//  ReGetCodeViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ReGetCodeViewController.h"
#import "LoginViewController.h"
#import "UIViewController+HUD.h"
#import "HexColor.h"
#import "MyAPI.h"
#import "Tools.h"

@interface ReGetCodeViewController ()<UITextFieldDelegate>
{
    NSTimer *timer;
    NSInteger time;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *YZMNum;

@property (weak, nonatomic) IBOutlet UITextField *RecommandNUm;
@property (weak, nonatomic) IBOutlet UITextField *codeNumber;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toplayout;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;

@end

@implementation ReGetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.RecommandNUm.delegate = self;
    self.testBtn.layer.cornerRadius = 5;
    self.testBtn.clipsToBounds = YES;
    self.SureBtn.layer.cornerRadius = 5;
    self.SureBtn.clipsToBounds = YES;
    self.testBtn.font = [UIFont systemFontOfSize:11];
    self.testBtn.titleLabel.textColor = [UIColor blackColor];
    
}

- (void)setTimeSchedu
{
    self.testBtn.enabled = NO;
    [self.testBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.testBtn setTitle:@"60" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    time = 60;
    [timer fire];
}

- (void)timeAct:(id)sender
{
    if(time == 0){
        [timer invalidate];
        self.testBtn.enabled = YES;
        [self.testBtn setBackgroundColor:[UIColor colorWithRed:251/255.0 green:150/255.0 blue:66/255.0 alpha:1]];
        [self.testBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        time--;
        [self.testBtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        [self.testBtn setBackgroundColor:[UIColor lightGrayColor]];

    }
}

- (IBAction)sendYZM:(UIButton*)sender {
   
   // __block int timeout = 60;
    NSString * phonenumber = self.phoneNum.text;
    if(self.phoneNum.text.length<11){
        [self showHint:@"请输入正确的手机号"];
        return;
    }
    [self setTimeSchedu];
    [[MyAPI sharedAPI] sendZhaoYZMWithPhoneNumber:phonenumber result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"验证码发送成功,请注意查看短信"];
        }else{
            [self showHint:@"验证码发送出错"];
        }

    } errorResult:^(NSError *enginerError) {
        
    }];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    
//    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
//    
//    dispatch_source_set_event_handler(_timer, ^{
//        if (timeout<0) {
//            dispatch_source_cancel(_timer);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [sender setImage:[UIImage imageNamed:@"getcode"] forState:UIControlStateNormal];
//                
//                sender.userInteractionEnabled = YES;
//            });
//        }else{
//            int seconds = timeout&61;
//            
//            NSString * strTime = [NSString stringWithFormat:@"%2d",seconds];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [sender setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
//                //   [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//                
//                sender.backgroundColor = [UIColor grayColor];
//                sender.userInteractionEnabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);

}

- (IBAction)FindBackPassWord:(id)sender {
    if (self.phoneNum.text.length == 0 ) {
        [self showHint:@"手机号不能为空"];
        return;
    }
    
    if (self.YZMNum.text.length==0) {
        [self showHint:@"验证码不能为空"];
        return;
    }
    
    if (!(self.codeNumber.text.length >= 6 && self.codeNumber.text.length <= 20)) {
        [self showHint:@"密码长度不符合要求"];
        return;
    }
    if(![self.RecommandNUm.text isEqualToString:self.codeNumber.text]){
        [self showHint:@"输入密码不一致"];
        return;
    }

    NSString * phonenumber = self.phoneNum.text;
    NSString * ACCountNum = self.codeNumber.text;
    NSString * SecurityAccountNum = [Tools loginPasswdSecurityLock:ACCountNum];
    NSString * SecurityRecommandNum = [Tools loginPasswdSecurityLock:self.RecommandNUm.text];
    NSString * TestNum = self.YZMNum.text;
    [[MyAPI sharedAPI] FindBackPasswordWithYZM:TestNum phoneNumber:phonenumber NewPassWord:SecurityAccountNum RePassWord:SecurityRecommandNum Result:^(BOOL sucess, NSString *msg) {
   
        if (sucess) {
            [self showHint:msg];
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            LoginViewController * VC = [storyboard instantiateViewControllerWithIdentifier:@"LOGIN"];
            [self.navigationController pushViewController:VC animated:YES];
      
        }else{
            [self showHint:msg];
            
        }

    } errorResult:^(NSError *enginerError) {
        
    }];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
     if(self.view.frame.size.height==480){
    [UIView animateWithDuration:0.3 animations:^{
        self.toplayout.constant = 10;
    }];
 }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
   
    [UIView animateWithDuration:0.3 animations:^{
        self.toplayout.constant = 51;
    }];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
