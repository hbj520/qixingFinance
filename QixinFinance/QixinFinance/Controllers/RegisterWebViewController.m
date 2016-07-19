//
//  RegisterWebViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "RegisterWebViewController.h"
#import "UIViewController+HUD.h"
#define READURL @"http://60.173.235.34:9090/qixin/app/nos_qx_agreement"
@interface RegisterWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RegisterWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:READURL]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHudInView:self.view hint:@"正在加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHud];
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
