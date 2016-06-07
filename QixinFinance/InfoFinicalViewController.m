//
//  InfoFinicalViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InfoFinicalViewController.h"
#import "UIViewController+HUD.h"
@interface InfoFinicalViewController ()

@end

@implementation InfoFinicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showHudInView:self.view hint:@"正在拼命搭建中"];
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
