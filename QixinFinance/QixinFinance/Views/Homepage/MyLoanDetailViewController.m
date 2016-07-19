//
//  MyLoanDetailViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/24.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyLoanDetailViewController.h"
#import "UIViewController+HUD.h"
#import "Config.h"
#define BASEURL @"http://60.173.235.34:9090/qixin/app/qx_borrowinfo/"
@interface MyLoanDetailViewController ()<UIWebViewDelegate>
{
    NSString * urlString;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MyLoanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.webView.delegate = self;
     NSString * token = [[Config Instance] getToken];
    urlString = [NSString stringWithFormat:@"%@%@",BASEURL,self.uid];
    NSURL  * url = [NSURL URLWithString:urlString];
    NSString * body = [NSString stringWithFormat:@"token=%@",token];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
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
