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
#define CHD_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
@interface AllLoanViewController ()<chdMenuDelegate>
{
    NSMutableArray * moneyArray;
    NSMutableArray * monthArray;
    NSMutableArray * sortArray;
}
@end

@implementation AllLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
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
        menu.tag = 10;
        
        menu.delegate = self;
    } errorResult:^(NSError *enginerError) {
        
    }];
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
