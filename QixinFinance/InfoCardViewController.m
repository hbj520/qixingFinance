//
//  InfoCardViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InfoCardViewController.h"
#import "UIViewController+HUD.h"
#import "HotInfoTableViewCell.h"
#import "InfoDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MyAPI.h"
#import "Marco.h"
@interface InfoCardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;

     NSMutableArray * selectData;
    
    NSInteger page;
}

@end

@implementation InfoCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
     _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    page = 1;
    [_tableView registerNib:[UINib nibWithNibName:@"HotInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"HOTCELL"];
    [self.view addSubview:_tableView];
    [self addRefresh];
    selectData = [NSMutableArray array];
      [self loadData];
}

- (void)addRefresh
{
    __weak InfoCardViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        if(selectData.count > 0){
            [selectData removeAllObjects];
        }
        [weakself loadData];
    }];
    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakself loadData];
    }];
    footerRefresh.automaticallyRefresh = NO;
    _tableView.mj_footer = footerRefresh;
}


- (void)loadData
{
    [self showHudInView:self.view hint:@"正在加载"];
     NSString * pageindex = [NSString stringWithFormat:@"%ld",page];
    [[MyAPI sharedAPI] requestNewsListWithPage:pageindex cateid:@"191" Result:^(BOOL success, NSString *msg, NSArray *arrays) {
        [selectData addObjectsFromArray:arrays[0]];
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [self hideHud];
    } errorResult:^(NSError *enginerError) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
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
    vc.titleName = @"信用卡";
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
