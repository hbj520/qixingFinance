//
//  AllLoanViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AllLoanViewController.h"
#import "MyAPI.h"
@interface AllLoanViewController ()

@end

@implementation AllLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
[[MyAPI sharedAPI] requestMoreLoanListWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
    NSLog(@"%@",arrays);
} errorResult:^(NSError *enginerError) {
    
}];
    
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
