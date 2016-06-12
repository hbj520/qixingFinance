//
//  HomeDetailViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "Config.h"
#define BASEURL @"http://60.173.235.34:9999/qixin/app/"
@interface HomeDetailViewController ()
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
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    
   
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = btnItem;

    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:webView];
    if(self.uid.length!=0){
    urlString = [NSString stringWithFormat:@"http://60.173.235.34:9999/qixin/app/nos_qx_loaninfo/%@",self.uid];
        self.manager = [[AFHTTPRequestOperationManager alloc] init];
        self.manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        [self.manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-access-id"];
        [self.manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-signature"];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString * token = [[Config Instance] getToken];
        if(token){
        NSDictionary * parameter = @{@"token":token};
        [self.manager POST:urlString parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
        }

    }else if (self.url.length!=0){
        urlString =  [NSString stringWithFormat:@" %@nos_qx_financeinfo/%@",BASEURL,self.url];
    }else{
        urlString = @"";
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [webView loadRequest:request];

    
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
