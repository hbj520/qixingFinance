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
#import "sortModel.h"
#define CHD_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
@interface AllLoanViewController ()<chdMenuDelegate>
{
    UIWebView * _webView;
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
        NSMutableArray *arr = [NSMutableArray array];
        NSArray * arrymoney = @[@"5",@"10",@"15",@"20",@"25",@"50",@"100",@"200",@"500",@"1000"];
       
        NSArray * arrymonth = @[@"3个月",@"6个月",@"12个月",@"2年",@"3年",@"5年",@"10年"];
      //  NSArray * arraysort = @[@"默认排序",@"总利息",@"月还款"];
        NSMutableArray *temp1 = [NSMutableArray array];
        NSMutableArray *temp2 = [NSMutableArray array];
        NSMutableArray *temp3 = [NSMutableArray array];
        NSMutableArray *temp4 = [NSMutableArray array];
        for(int i = 0;i<10;i++){
            
            chdModel * model = [[chdModel alloc] init];
            model.text = [NSString stringWithFormat:@"%@万元",arrymoney[i]];
            [temp1 addObject:model];
        }
        
        for(int i=0;i<7;i++){
            chdModel *model = [[chdModel alloc]init];
            model.text = arrymonth[i];
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
