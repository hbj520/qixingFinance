//
//  FormuViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/25.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "FormuViewController.h"
#import "UIViewController+HUD.h"
#import "FirstStyleTableViewCell.h"
#import "SecondTableViewCell.h"
#import "LoanInfoTableViewCell.h"
#import "HomeDetailViewController.h"
#import "AllLoanViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "JobInfoModel.h"
#import "CHDDropDownMenu.h"
#import "MyAPI.h"
@interface FormuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * moreloanArray;//存放更多贷款模型的数组
}
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation FormuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
       [self.view addSubview:self.tableView];
   
   // [self addMJRefreshHasHeader:NO withHasFooter:YES];
    self.tableView.separatorStyle = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
   [self loadData];
    [self configUI];
}






//加载更多贷款数据
- (void)loadData
{
    [self showHudInView:self.view hint:@"加载中..."];
[[MyAPI sharedAPI] getrecommandIoaninfoWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
    if (success) {
      
                moreloanArray = arrays;
        [self.tableView reloadData];
        [self hideHud];
    }
} errorResult:^(NSError *enginerError) {
   
    }];
}

//搭建界面UI
- (void)configUI
{
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstStyleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
   [self.tableView registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"celltwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoanInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        return moreloanArray.count;
    }else{
    return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FirstStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak FormuViewController * weakself = self;
        cell.block = ^(JobInfoModel* model){
            
            /**
             *  按照职业跳到全部贷款页面
             */
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
            AllLoanViewController *VC = (AllLoanViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AllLoan"];
            VC.jtype = model.jobid;
            [weakself.navigationController pushViewController:VC animated:YES];
            
        };
             return cell;
    }else if(indexPath.section==1){
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celltwo" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
              return cell;
    }else{
        moreloaninfoModel * model = moreloanArray[indexPath.row];
        LoanInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else if (section==1){
        return 20;
    }
    else{
        return 2;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 250;
    }else if (indexPath.section==1){
        return 47;
    }
    else{
        return 90;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
      
        //跳到全部贷款界面
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
       AllLoanViewController *VC = (AllLoanViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AllLoan"];
        VC.jtype = @"";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
   else if (indexPath.section==2) {
       
       //跳到贷款详情界面
        moreloaninfoModel * model = moreloanArray[indexPath.row];
        HomeDetailViewController * vc = [[HomeDetailViewController alloc] init];
        vc.uid = model.infoId;
        [self.navigationController pushViewController:vc animated:YES];
   }else{
       
   }
}

//回退
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
