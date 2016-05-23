//
//  InfoHotViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InfoHotViewController.h"

@interface InfoHotViewController ()
{
    UIWebView * _webView;
}
@end

@implementation InfoHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"all_loans" ofType:@"html"];
 //   NSString * htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL  fileURLWithPath:filePath]];
    [_webView loadRequest:request];
    [_webView sizeToFit];
    [self.view addSubview:_webView];
   
    
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
