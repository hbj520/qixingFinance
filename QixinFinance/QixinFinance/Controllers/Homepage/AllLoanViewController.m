//
//  AllLoanViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AllLoanViewController.h"
#import "CHDDropDownMenu.h"
#import "MyAPI.h"
#import "moneyModel.h"
#import "monthModel.h"
#import "sortModel.h"
#import "moreloaninfoModel.h"
#import "LoanInfoTableViewCell.h"
#import "HomeDetailViewController.h"
#import "Config.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define CHD_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
@interface AllLoanViewController ()<chdMenuDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray * moneyArray;
    NSMutableArray * monthArray;
    NSMutableArray * sortArray;
    NSMutableArray * moreLoanListArray;
    UITableView * _tableView;
}
@end

@implementation AllLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.money = @"";
    self.month = @"";
    self.sort = @"";
    
    // Do any additional setup after loading the view.
    [self loadData];
  [self loadLoanListData];
    [self configTableView];
  
    //列表展示的模型
      }


- (void)loadData
{
    [[MyAPI sharedAPI] requestMoreLoanListWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
        sortArray = arrays[0];
        moneyArray = arrays[6];
        monthArray = arrays[7];
        NSMutableArray *arr = [NSMutableArray array];
       
             NSMutableArray *temp1 = [NSMutableArray array];
        NSMutableArray *temp2 = [NSMutableArray array];
        NSMutableArray *temp3 = [NSMutableArray array];
        NSMutableArray *temp4 = [NSMutableArray array];
        for(int i = 0;i<moneyArray.count;i++){
            moneyModel * model1 = [[moneyModel alloc] init];
            model1 = moneyArray[i];
            chdModel * model = [[chdModel alloc] init];
            model.text = model1.value;
            model.uid = model1.money;
            [temp1 addObject:model];
        }
        
        for(int i=0;i<monthArray.count;i++){
            monthModel * model1 = [[monthModel alloc] init];
            model1 = monthArray[i];
            chdModel *model = [[chdModel alloc]init];
            model.text = model1.value;
            model.uid = model1.month;
            [temp2 addObject:model];
        }
        
        for(int i = 0;i<sortArray.count;i++){
            sortModel * model1 = [[sortModel alloc] init];
            model1 = sortArray[i];
            chdModel * model = [[chdModel alloc]init];
            model.text = model1.name;
            model.uid = model1.sort;
            [temp3 addObject:model];
        }
        chdModel * model = [[chdModel alloc]init];
        model.text = @"筛选";
        [temp4 addObject:model];
        [arr addObject:temp1];
        [arr addObject:temp2];
        [arr addObject:temp3];
        [arr addObject:temp4];
        //若列表展示内容与按钮展示内容相同则showArr传nil即可。
        
      CHDDropDownMenu * menu =  [[CHDDropDownMenu alloc] initWithFrame:CGRectMake(0,64,CHD_SCREEN_WIDTH, 40) showOnView:self.view AllDataArr:arr showArr:nil];
        
        menu.delegate = self;
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    
   }

- (void)loadLoanListData
{
    [[MyAPI sharedAPI] getMoreLoanWithSort:self.sort jtype:self.jtype mtype:@"" rtype:@"" btype:@""month:self.month money:self.money page:@"1" Result:^(BOOL success, NSString *msg, NSArray *arrays) {
        NSLog(@"%lu",(unsigned long)arrays.count);
       moreLoanListArray = arrays[0];
       
        [_tableView reloadData];
    } errorResult:^(NSError *enginerError) {
        
    }];

}

- (void)configTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,65, CHD_SCREEN_WIDTH, self.view.frame.size.height-120) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"LoanInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    _tableView.delegate= self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moreLoanListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    moreloaninfoModel  * model = [[moreloaninfoModel alloc] init];
    model = moreLoanListArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    moreloaninfoModel * model = moreLoanListArray[indexPath.row];
    HomeDetailViewController * vc = [[HomeDetailViewController alloc] init];
    vc.uid = model.infoId;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  前三组数据回调
 *
 *  @param colum
 *  @param row
 *  @param model 数据模型包含要传递的id
 */
- (void)selectColum:(NSInteger)colum Row:(NSInteger)row Model:(chdModel *)model
{
    
    if(colum==0){
        if (row==0) {
         self.money = @"";
        }else{
        self.money = model.uid;
        }
    }else if (colum==1){
        self.month = model.uid;
    }else if (colum==2){
        self.sort = model.uid;
    }
    [self loadLoanListData];
    NSLog(@"%@",model.uid);
}

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
