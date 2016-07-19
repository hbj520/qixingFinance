//
//  InfoLoanViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InfoLoanViewController.h"
#import "UIViewController+HUD.h"
#import "HotInfoTableViewCell.h"
#import "InfoDetailViewController.h"
#import "MyAPI.h"
#import "Marco.h"
@interface InfoLoanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    
    NSMutableArray * selectData;
    
}
@end

@implementation InfoLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
     _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"HotInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"HOTCELL"];
    [self.view addSubview:_tableView];
    [self loadData];

}

- (void)loadData
{
    [self showHudInView:self.view hint:@"正在加载"];
    [[MyAPI sharedAPI] requestNewsListWithPage:@"1" cateid:@"193" Result:^(BOOL success, NSString *msg, NSArray *arrays) {
        selectData = arrays[0];
        [_tableView reloadData];
        [self hideHud];
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selectData.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"HOTCELL";
    HotInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    InfoCateModel * model = [[InfoCateModel alloc] init];
    model = selectData[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoDetailViewController * vc = [[InfoDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    InfoCateModel * model = [[InfoCateModel alloc] init];
    model = selectData[indexPath.row];
    vc.titleName = @"贷款";
    vc.articleid = model.articleid;
    [self.navigationController pushViewController:vc animated:YES];
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
