//
//  AllLoanViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AllLoanViewController.h"
#import "CHDDropDownMenu.h"
#import "MyAPI.h"
#define CHD_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
@interface AllLoanViewController ()
{
    UIWebView * _webView;
}
@end

@implementation AllLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
[[MyAPI sharedAPI] requestMoreLoanListWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
    NSLog(@"%@",arrays);
} errorResult:^(NSError *enginerError) {
    
}];
    //列表展示的模型
    NSMutableArray *arr = [NSMutableArray array];
    NSArray * arrymoney = @[@"5",@"10",@"15",@"20",@"25",@"50",@"100",@"200",@"500",@"1000"];
    NSArray * arrymonth = @[@"3个月",@"6个月",@"12个月",@"2年",@"3年",@"5年",@"10年"];
    NSArray * arraysort = @[@"默认排序",@"总利息",@"月还款"];
    NSMutableArray *temp1 = [NSMutableArray array];
    NSMutableArray *temp2 = [NSMutableArray array];
    NSMutableArray *temp3 = [NSMutableArray array];
    NSMutableArray *temp4 = [NSMutableArray array];
    for(int i = 0;i<10;i++){
        
        chdModel * model = [[chdModel alloc] init];
        model.text = [NSString stringWithFormat:@"%@万元",arrymoney[i]];
        [temp1 addObject:model];
    }
    
    for(int i=0;i<7;i++){
        chdModel *model = [[chdModel alloc]init];
        model.text = arrymonth[i];
        [temp2 addObject:model];
    }
    
    for(int i = 0;i<3;i++){
        chdModel * model = [[chdModel alloc]init];
        model.text = arraysort[i];
        [temp3 addObject:model];
    }
    chdModel * model = [[chdModel alloc]init];
    model.text = @"筛选";
    [temp4 addObject:model];
    [arr addObject:temp1];
    [arr addObject:temp2];
    [arr addObject:temp3];
    [arr addObject:temp4];
    //若列表展示内容与按钮展示内容相同则showArr传nil即可。
    
    [[CHDDropDownMenu alloc] initWithFrame:CGRectMake(0,64,CHD_SCREEN_WIDTH, 40) showOnView:self.view AllDataArr:arr showArr:nil];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40)];
    [self.view addSubview:_webView];
    [self.view sendSubviewToBack:_webView];
    UIButton * backbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 45, 45)];
  //  backbtn.backgroundColor = [UIColor redColor];
    [backbtn setTitle:@"back" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [_webView addSubview:backbtn];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://60.173.235.34:9999/qixin/app/nos_qx_loanlist"]];
    [_webView loadRequest:request];
}

- (void)goback
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
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
