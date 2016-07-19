//
//  HomeDetailViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

//贷款详情

#import "HomeDetailViewController.h"
#import "UIViewController+HUD.h"
#import "Config.h"
#define BASEURL @"http://60.173.235.34:9090/qixin/app/nos_qx_loaninfo/"
@interface HomeDetailViewController ()<UIWebViewDelegate>
{
    
    UIWebView * webView;//网页界面
    
    NSString * urlString; //网址
    
}
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 45, 45);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    
   
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = btnItem;

    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate = self;
    [self.view addSubview:webView];
    if(self.uid.length!=0){
          NSString * token = [[Config Instance] getToken];
        if (token.length==0) {
            urlString = [NSString stringWithFormat:@"%@%@",BASEURL,self.uid];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
             [webView loadRequest:request];
        }else{
            urlString = [NSString stringWithFormat:@"%@%@",BASEURL,self.uid];
            NSURL  * url = [NSURL URLWithString:urlString];
            NSString * body = [NSString stringWithFormat:@"token=%@",token];
            NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
            [webView loadRequest:request];

        }
            
    
    }else if (self.url.length!=0){
        urlString =  [NSString stringWithFormat:@" %@nos_qx_loaninfo/%@",BASEURL,self.url];
    }else{
        urlString = @"";
    }


    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHudInView:self.view hint:@"正在加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHud];
}

- (void)back
{
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
