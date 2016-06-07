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
#import "selectView.h"
#import "Config.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define CHD_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
@interface AllLoanViewController ()<chdMenuDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray * moneyArray;//金额模型数组
    
    NSMutableArray * monthArray;//周期模型数组
    
    NSMutableArray * sortArray;//筛选模型数组
    
    NSMutableArray * moreLoanListArray;//更多贷款模型数组
    
    UITableView * _tableView;//更多贷款界面
    
    selectView * selectV;//筛选界面
    
    __block chdButton * button;//筛选按钮
    
}
@end




@implementation AllLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.money = @"";
    self.month = @"";
    self.sort = @"";
    self.mtype = @"";
    self.rtype = @"";
    self.btype = @"";
    // Do any additional setup after loading the view.
    [self loadData];
  [self loadLoanListData];
    [self configTableView];
   
    selectV = [[selectView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100)];
    selectV.hidden = YES;
    __weak AllLoanViewController * weakself = self;
    selectV.block = ^(NSString * str1,NSString * str2,NSString * str3,NSString * str4){
        NSLog(@"%@  %@  %@  %@",str1,str2,str3,str4);
        //点击完成改变动画效果，并传递数据
       button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        weakself.jtype = str1;
        weakself.mtype =  str2;
        weakself.btype = str3;
        weakself.rtype = str4;
        [weakself loadLoanListData];
    };
    
    [self.view addSubview:selectV];
    //列表展示的模型
      }


//加载数据
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
      
        
         button = [[chdButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4*3, 64, self.view.frame.size.width/4, 40)];
        [button setTitle:@"筛选" forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        button.tag = 10;
        button.layer.borderWidth = 0.4;
        [button setImage:[UIImage imageNamed:@"up1"] forState:UIControlStateNormal];
        button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        button.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(hideselectV:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        menu.delegate = self;
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    
   }

//筛选按钮响应事件
- (void)hideselectV:(UIButton*)btn
{
   
    [UIView animateWithDuration:0.2 animations:^{
         bool hide = selectV.hidden;
           hide = !hide;
        selectV.hidden = hide;
        if(hide==YES){
        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            btn.imageView.transform = CGAffineTransformMakeRotation(0);
        }
    }];

}

//加载更多贷款数据
- (void)loadLoanListData
{
    [[MyAPI sharedAPI] getMoreLoanWithSort:self.sort jtype:self.jtype mtype:self.mtype rtype:self.rtype btype:self.btype month:self.month money:self.money page:@"1" Result:^(BOOL success, NSString *msg, NSArray *arrays) {
        NSLog(@"%lu",(unsigned long)arrays.count);
       moreLoanListArray = arrays[0];
       
        [_tableView reloadData];
    } errorResult:^(NSError *enginerError) {
        
    }];

}

//搭建UI
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


//跳到更多贷款详情界面
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
