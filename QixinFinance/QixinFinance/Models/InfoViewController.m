//
//  InfoViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InfoViewController.h"
#import "SCNavTabBarController.h"
#import "YSLContainerViewController.h"
#import "InfoHotViewController.h"
#import "InfoCardViewController.h"
#import "InfoFinicalViewController.h"
#import "InfoLoanViewController.h"
#import "InfoFinialGuardViewController.h"

@interface InfoViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    InfoHotViewController * oneVc = [[InfoHotViewController alloc] init];
    oneVc.title = @"热点";
    InfoCardViewController * twoVc = [[InfoCardViewController alloc] init];
    twoVc.title = @"信用卡";
    InfoFinicalViewController * threeVc = [[InfoFinicalViewController alloc] init];
    threeVc.title = @"理财";
    InfoLoanViewController * fourVc = [[InfoLoanViewController alloc] init];
    fourVc.title = @"贷款";
    InfoFinialGuardViewController * fiveVc = [[InfoFinialGuardViewController alloc] init];
    fiveVc.title = @"金融卫士";
//    navTabBarController.subViewControllers = @[oneVc,twoVc,threeVc,fourVc,fiveVc];
//    [navTabBarController addParentController:self];
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[oneVc,twoVc,threeVc,fourVc,fiveVc]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;
    
    containerVC.menuItemFont = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:containerVC.view];

}

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
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
