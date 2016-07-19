//
//  SelectProductViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SelectProductViewController.h"
#import "MyAPI.h"
#import "gfselectModel.h"
#import "financialProductTableViewCell.h"
#import "HomeDetailViewController.h"
#import "SelectProductDetailViewController.h"
#import "UIViewController+HUD.h"
#import <MJRefresh/MJRefresh.h>

@interface SelectProductViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dataSource;
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self configTableView];
   
    [self loadData];
     [self addRefresh];
}


- (void)addRefresh
{
    __weak SelectProductViewController * weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      
        page = 1;
        [weakself loadData];
    }];
    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakself loadData];
    }];
    footerRefresh.automaticallyRefresh = NO;
    self.tableView.mj_footer = footerRefresh;
}

- (void)loadData
{
    NSString * pagestr = [NSString stringWithFormat:@"%ld",(long)page];
    
    [self showHudInView:self.view hint:@"正在加载"];
    [[MyAPI  sharedAPI] requestSelectLoanListWithPage:pagestr Result:^(BOOL success, NSString *msg, NSArray *arrays) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
       // [dataSource addObjectsFromArray:arrays[0]];
        dataSource = arrays[0];
        [self.tableView reloadData];
        [self hideHud];
    } errorResult:^(NSError *enginerError) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)configTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"financialProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"homepageReusedId6"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"homepageReusedId6";
    financialProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    gfselectModel * model = [[gfselectModel alloc] init];
    model = dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    gfselectModel * model = dataSource[indexPath.row];
    SelectProductDetailViewController * VC = [[SelectProductDetailViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.uid = model.selectId;
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
