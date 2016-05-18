//
//  HomepageViewController.m
//  QixinFinance
//
//  Created by youyou on 16/5/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomepageViewController.h"

@interface HomepageViewController ()

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showTitleView];
    [self showCityName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)showCityName{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"合肥" style:UIBarButtonItemStyleDone target:self action:@selector(cityAct:)];
    barButtonItem.tintColor = [UIColor grayColor];
    UIBarButtonItem *barbuttonItemImg = self.navigationItem.rightBarButtonItem;
    NSArray *buttonItems = @[barButtonItem,barbuttonItemImg];
   // [buttonItems addObject:barButtonItem];
    self.navigationItem.rightBarButtonItems = buttonItems;
}
- (void)cityAct:(id)sender{
    
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
