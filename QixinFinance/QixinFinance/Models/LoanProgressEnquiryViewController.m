//
//  LoanProgressEnquiryViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LoanProgressEnquiryViewController.h"
#import "MYloanDetailViewController.h"
#import "UIViewController+HUD.h"
#import "MyLoanModel.h"
#import "MyLoanTableViewCell.h"
#import "MyAPI.h"

@interface LoanProgressEnquiryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * MyLoanArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LoanProgressEnquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyLoanTableViewCell" bundle:nil] forCellReuseIdentifier:@"MYLOAN"];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    //[self showHudInView:self.view hint:@"正在加载"];
  
    [[MyAPI sharedAPI] getMyLoanListWithPage:@"1" Result:^(BOOL success, NSString *msg, NSArray *arrays) {
     //   MyLoanArray = [NSMutableArray array];
        
        MyLoanArray = arrays[0];
        
        [self.tableView reloadData];
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
    return MyLoanArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyLoanModel * model = [[MyLoanModel alloc] init];
    model = MyLoanArray[indexPath.row];
    if(model==MyLoanArray.lastObject){
        return 170;
    }else{
    return 180;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MYLOAN" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    MyLoanModel * model = [[MyLoanModel alloc] init];
    model = MyLoanArray[indexPath.row];
    if(model==MyLoanArray.lastObject){
        cell.lineView.hidden = YES;
    }
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyLoanModel * model = [[MyLoanModel alloc] init];
    model = MyLoanArray[indexPath.row];
    if ([model.status isEqualToString:@"贷款进行中..."]) {
        [self showHint:@"贷款进行中"];
        return;
    }
    [self performSegueWithIdentifier:@"loandetailsegue" sender:model.uid];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MyLoanDetailViewController * vc = segue.destinationViewController;
    vc.uid = sender;
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
