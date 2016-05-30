//
//  FormuViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/25.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "FormuViewController.h"
#import "FirstStyleTableViewCell.h"
#import "SecondTableViewCell.h"
@interface FormuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@end

@implementation FormuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self configUI];
}

- (void)configUI
{
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstStyleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
   [self.tableView registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"celltwo"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FirstStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak FormuViewController * weakself = self;
        cell.block = ^(){
            [weakself pushVC];
        };
        return cell;
    }else{
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celltwo" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
        return 20;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 250;
    }else{
        return 450;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1){
        [self.tableView setContentOffset:CGPointMake(0, 180)];
      
    }
}
- (void)pushVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
    FormuViewController *VC = (FormuViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AllLoan"];
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
