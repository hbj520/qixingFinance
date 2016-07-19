//
//  InfoDetailViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "UIViewController+HUD.h"
#define URL @"http://60.173.235.34:9090/qixin/app/nos_qx_articleinfo/"
@interface InfoDetailViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
}
@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = btnItem;

    NSString * url = [NSString stringWithFormat:@"http://60.173.235.34:9090/qixin/app/nos_qx_articleinfo/%@",self.articleid];
     NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
}

#pragma mark -PRIVATEMETHOD
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   self.navigationItem.title = self.titleName;
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
