//
//  HomepageViewController.m
//  QixinFinance
//
//  Created by youyou on 16/5/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomepageViewController.h"
#import "ThreeTableViewCell.h"
#import "ActivityTableViewCell.h"
#import "recommandLoanTableViewCell.h"
#import "bankLoanTableViewCell.h"
#import "HotCardTableViewCell.h"
#import "financialProductTableViewCell.h"
#import "financialSelectedTableViewCell.h"
@interface HomepageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showTitleView];
   // [self showCityName];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self congfigTableView];
}

- (void)cityLocation
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    [btn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
   
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = btnItem;
}



- (void)congfigTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[ThreeTableViewCell class] forCellReuseIdentifier:@"homepageReused7"];
    [self.tableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"homepageReused1"];
   // [self.tableView registerClass:[recommandLoanTableViewCell class] forCellReuseIdentifier:@"homepageReused2"];
    [self.tableView registerClass:[bankLoanTableViewCell class] forCellReuseIdentifier:@"homepageReused3"];
   [ self.tableView registerClass:[HotCardTableViewCell class] forCellReuseIdentifier:@"homepageReused4"];
    [self.tableView registerClass:[financialSelectedTableViewCell class] forCellReuseIdentifier:@"homepageReusedId5"];
    //[self.tableView registerClass:[financialProductTableViewCell class] forCellReuseIdentifier:@"homepageReusedId6"];
   [self.tableView registerNib:[UINib nibWithNibName:@"recommandLoanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
      [self.tableView registerNib:[UINib nibWithNibName:@"financialProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"homepageReusedId6"];
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    footView.backgroundColor = [UIColor lightGrayColor];
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 80, 30)];
    label1.textColor = [UIColor orangeColor];
    label1.backgroundColor =  [UIColor lightGrayColor];

    label1.text = @"小编点评";
    label1.font = [UIFont systemFontOfSize:12];
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 7, 300, 30)];
    label2.textColor = [UIColor blackColor];
    label2.text = @"自动投标，操作方便；本息复投，提高资金利用率。";
    label2.backgroundColor =  [UIColor lightGrayColor];

    label2.font = [UIFont systemFontOfSize:11];
    [footView addSubview:label1];
    [footView addSubview:label2];
    self.tableView.tableFooterView = footView;
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    headView.backgroundColor = [UIColor blackColor];
    self.tableView.tableHeaderView = headView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==3||section==6) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ThreeTableViewCell * cell = [[ThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"homepageReused7"];
            return cell;
    }else if (indexPath.section==1){
        ActivityTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:self options:nil] lastObject];
        return cell;

    }else if (indexPath.section==2){
        bankLoanTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"bankLoanTableViewCell" owner:self options:nil]  lastObject];
        return cell;
    }else if (indexPath.section==3){
        recommandLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==4){
        HotCardTableViewCell * cell =  [[[NSBundle mainBundle] loadNibNamed:@"HotCardTableViewCell" owner:self options:nil] lastObject];
        return cell;

    }else if (indexPath.section==5){
        financialSelectedTableViewCell * cell =  [[[NSBundle mainBundle] loadNibNamed:@"financialSelectedTableViewCell" owner:self options:nil] lastObject];
        return cell;

    }else if (indexPath.section==6){
        financialProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homepageReusedId6" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else if (section == 1){
        return 10;
    }else if (section == 2){
        return 20;
    }else if (section == 3){
        return 4;
    }else if (section == 4){
        return 20;
    }else if (section == 5){
        return 20;
    }else if (section == 6){
        return 4;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0||indexPath.section==1||indexPath.section==3||indexPath.section==6) {
        return 106;
    }else if (indexPath.section==2||indexPath.section==5){
        return 44;
    }else{
        return 200;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PrivateMethod
- (void)showCityName{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"合肥" style:UIBarButtonItemStyleDone target:self action:@selector(cityAct:)];
    barButtonItem.tintColor = [UIColor grayColor];
    UIBarButtonItem *barbuttonItemImg = self.navigationItem.rightBarButtonItem;
    NSArray *buttonItems = @[barButtonItem,barbuttonItemImg];
   // [buttonItems addObject:barButtonItem];
    self.navigationItem.rightBarButtonItems = buttonItems;
}
- (void)cityAct:(id)sender{
    
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
