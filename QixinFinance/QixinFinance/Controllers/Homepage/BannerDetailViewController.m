//
//  BannerDetailViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/2.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BannerDetailViewController.h"
#import "UIViewController+HUD.h"
@interface BannerDetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation BannerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.bannerUrl]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHudInView:self.view hint:@"正在加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHud];
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
