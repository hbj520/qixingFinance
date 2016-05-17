//
//  HomeTabbarViewController.m
//  QixinFinance
//
//  Created by youyou on 16/5/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomeTabbarViewController.h"
#import "HexColor.h"

@interface HomeTabbarViewController ()
{
    NSArray *titleArrays;
    NSMutableArray *menusVCs;//tabbars的控制器们
}
@property (nonatomic,strong) UIStoryboard *homePageSB;
@property (nonatomic,strong) UIStoryboard *informationSB;
@property (nonatomic,strong) UIStoryboard *forumSB;
@property (nonatomic,strong) UIStoryboard *personalSB;
@end

@implementation HomeTabbarViewController
- (UIStoryboard *)homePageSB{
    if (!_homePageSB) {
        _homePageSB = [UIStoryboard storyboardWithName:@"Homepage" bundle:[NSBundle mainBundle]];
    }
    return _homePageSB;
}
- (UIStoryboard *)informationSB{
    if (!_informationSB) {
        _informationSB = [UIStoryboard storyboardWithName:@"Information" bundle:[NSBundle mainBundle]];
    }
    return _informationSB;
}
- (UIStoryboard *)forumSB{
    if (!_forumSB) {
        _forumSB = [UIStoryboard storyboardWithName:@"Forum" bundle:[NSBundle mainBundle]];
    }
    return _forumSB;
}
- (UIStoryboard *)personalSB{
    if (!_personalSB) {
        _personalSB = [UIStoryboard storyboardWithName:@"Personal" bundle:[NSBundle mainBundle]];
    }
   return _personalSB;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor colorWith8BitRed:77 green:177 blue:226];
    menusVCs = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeTabbars" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *array = dict[@"tabBarMenus"];
    for (NSDictionary *dic in array) {
        UITabBarItem *tabbarItem = [[UITabBarItem alloc] init];
        [tabbarItem setImage:[UIImage imageNamed:dic[@"image"]]];
        [tabbarItem setSelectedImage:[UIImage imageNamed:dic[@"select_image"]]];
        [tabbarItem setTitle:dic[@"title"]];
        SEL selector = NSSelectorFromString(dic[@"storybordId"]);
        IMP imp = [self methodForSelector:selector];
        UIStoryboard * (*func)(id,SEL) = (void *)imp;
        UIStoryboard *sb = func(self,selector);
        UIViewController *vc = [sb instantiateInitialViewController];
        vc.tabBarItem = tabbarItem;
        [menusVCs addObject:vc];
        
    }
    self.viewControllers = menusVCs;
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
