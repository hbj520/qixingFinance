//
//  BaseViewController.m
//  QixinFinance
//
//  Created by youyou on 16/5/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)showTitleView{
    UIImageView *titleImagView = [[UIImageView alloc] init];
    titleImagView.frame = CGRectMake(0, 0, 145, 40);
    titleImagView.image = [UIImage imageNamed:@"navtitleview"];
    self.navigationItem.titleView = titleImagView;
}
- (void)LocalAct:(id)sender{
    
}
- (void)LocalCityAct:(id)sender{
    
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
