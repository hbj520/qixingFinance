//
//  InfoHotViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InfoHotViewController.h"
#import "UIViewController+HUD.h"
#import "SDCycleScrollView.h"
#import "MyAPI.h"
#import "adverModel.h"
#import "HotInfoTableViewCell.h"
#import "InfoDetailViewController.h"
#import "BannerDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "Marco.h"

@interface InfoHotViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
    UITableView * _tableView;
    
    NSMutableArray * _imgArray;  //存放轮播图图片网址的数组
    
    NSMutableArray * imageArray; //存放轮播图模型的数组
    
    NSMutableArray * selectData;  //接收轮播图数据模型的数组
    
    NSMutableArray * loaninfoData; //接收首页数据模型的数组
    
    SDCycleScrollView * _headView;  //轮播图
    NSInteger page;

}
@end

@implementation InfoHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150 ) style:UITableViewStylePlain];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"HotInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"HOTCELL"];
    [self.view addSubview:_tableView];
    selectData = [NSMutableArray array];
    [self addRefresh];
    [self configpageView];
    [self loadData];
}

- (void)configpageView
{
    
    [[MyAPI sharedAPI] getInfoPageBannerWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
        imageArray  = arrays[0];
        _imgArray  = [[NSMutableArray alloc] init];
        for(adverModel * model in imageArray){
            [_imgArray addObject:model.adimageUrl];
        }
        _headView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth,200 ) imageURLStringsGroup:_imgArray];
        _headView.placeholderImage = [UIImage imageNamed:@"bannerimage"];
        _headView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headView.delegate = self;
        _tableView.tableHeaderView = _headView;
       
    } errorResult:^(NSError *enginerError) {
       
    }];
}

- (void)addRefresh
{
    __weak InfoHotViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        if(selectData.count>0){
            [selectData removeAllObjects];
        }
        [weakself loadData];
        //[weakself configpageView];
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
    [[MyAPI sharedAPI] requestNewsListWithPage:pageindex cateid:@"190" Result:^(BOOL success, NSString *msg, NSArray *arrays) {
        //selectData = arrays[0];
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
    vc.articleid = model.articleid;
    vc.titleName = @"热点";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
    BannerDetailViewController *VC = (BannerDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Banner"];
    adverModel *model = [imageArray objectAtIndex:index];

    VC.bannerUrl = model.link;
    [self.navigationController pushViewController:VC animated:YES];
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
