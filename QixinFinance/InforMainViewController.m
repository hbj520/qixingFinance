//
//  InforMainViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InforMainViewController.h"
#import "UIParameter.h"
#import "NinaPagerView.h"

@interface InforMainViewController ()

@end

@implementation InforMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    NSArray *titleArray =   @[
                              @"热点",
                              @"信用卡",
                              @"理财",
                              @"贷款",
                              @"金融卫士"
                              ];
    NSArray *vcsArray = @[
                          @"InfoHotViewController",
                          @"InfoCardViewController",
                          @"InfoFinicalViewController",
                          @"InfoLoanViewControllerr",
                          @"InfoFinialGuardViewController",
                          ];

    NSArray *colorArray = @[
                            [UIColor blackColor], /**< 选中的标题颜色 Title SelectColor  **/
                            [UIColor blackColor], /**< 未选中的标题颜色  Title UnselectColor **/
                            [UIColor clearColor], /**< 下划线颜色 Underline Color   **/
                            ];

    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    
    [self.navigationController.navigationBar addSubview:ninaPagerView];

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
