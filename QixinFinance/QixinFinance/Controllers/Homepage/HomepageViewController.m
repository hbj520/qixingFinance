//
//  HomepageViewController.m
//  QixinFinance
//
//  Created by youyou on 16/5/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomepageViewController.h"
#import "SelectProductViewController.h"
#import "UIViewController+HUD.h"
#import "ThreeTableViewCell.h"
#import "ActivityTableViewCell.h"
#import "recommandLoanTableViewCell.h"
#import "bankLoanTableViewCell.h"
#import"HotCardCommandViewCellTableViewCell.h"
#import "financialProductTableViewCell.h"
#import "financialSelectedTableViewCell.h"
#import "SDCycleScrollView.h"
#import "HomeDetailViewController.h"
#import "FormuViewController.h"
#import "AllLoanViewController.h"
#import "BannerDetailViewController.h"
#import "SelectProductDetailViewController.h"
#import "MyAPI.h"
#import "loaninfoModel.h"
#import "gfselectModel.h"
#import "adverModel.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface HomepageViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
    NSMutableArray * _imgArray;  //存放轮播图图片网址的数组
    
    NSMutableArray * imageArray; //存放轮播图模型的数组
    
    NSMutableArray * HomePictureArray1;
    
    NSMutableArray * HomePictureArray2;

    NSMutableArray * selectData;  //接收轮播图数据模型的数组
    
    NSMutableArray * loaninfoData; //接收首页数据模型的数组
    
    SDCycleScrollView * _headView;  //轮播图
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showTitleView];
   // [self showCityName];
    //[self cityLocation];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self congfigTableView];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //self.navigationItem.;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}


/**
 *  创建滚动视图
 */
- (void)configPageView
{
    [[MyAPI sharedAPI] getHomepageBannerWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
        imageArray = arrays[0];
        for(adverModel * model in imageArray){
            [_imgArray addObject:model.adimageUrl];
        }
        _headView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth,200 ) imageURLStringsGroup:_imgArray];
        _headView.placeholderImage = [UIImage imageNamed:@"bannerimage"];
         _headView.delegate = self;
        self.tableView.tableHeaderView = _headView;
        
       
        
    } errorResult:^(NSError *enginerError) {
        
    }];

}

/**
 *  加载首页数据
 */
- (void)loadData
{
    
    [self showHudInView:self.view hint:@"加载中..."];
    [[MyAPI sharedAPI] getHomepageDataWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
        //imageArray = arrays[0];
        selectData = arrays[0];
        loaninfoData = arrays[1];
        [self configPageView];
        [self.tableView reloadData];
         [self hideHud];
        _imgArray  = [[NSMutableArray alloc] init];
     //   NSString * imgPath = @"cycleviewicon";
        for(NSInteger i = 0 ;i<3;i++){
            //adverModel * model = imageArray[0];
           // [_imgArray addObject:model.adimageUrl];
        }
        
            } errorResult:^(NSError *enginerError) {
        
    }];
    
    [[MyAPI sharedAPI] getHomePagePictureWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
    
        NSMutableArray * HomePictureArray = arrays[0];
       HomePictureArray1 = HomePictureArray;
        [self.tableView reloadData];
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    [[MyAPI sharedAPI] getHomePageCardPictureWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
        NSMutableArray * HomePageCardPictureArray = arrays[0];
        HomePictureArray2 = HomePageCardPictureArray;
        [self.tableView reloadData];
    } errorResult:^(NSError *enginerError) {
        
    }];
    
}

- (void)cityLocation
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setImage:[UIImage imageNamed:@"rightnavbutton"] forState:UIControlStateNormal];

    
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = btnItem;
}



- (void)congfigTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    [self.tableView registerClass:[ThreeTableViewCell class] forCellReuseIdentifier:@"homepageReused7"];
    [self.tableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"homepageReused1"];
   // [self.tableView registerClass:[recommandLoanTableViewCell class] forCellReuseIdentifier:@"homepageReused2"];
    [self.tableView registerClass:[bankLoanTableViewCell class] forCellReuseIdentifier:@"homepageReused3"];
   [ self.tableView registerClass:[HotCardCommandViewCellTableViewCell class] forCellReuseIdentifier:@"homepageReused4"];
    [self.tableView registerClass:[financialSelectedTableViewCell class] forCellReuseIdentifier:@"homepageReusedId5"];
    //[self.tableView registerClass:[financialProductTableViewCell class] forCellReuseIdentifier:@"homepageReusedId6"];
   [self.tableView registerNib:[UINib nibWithNibName:@"recommandLoanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
      [self.tableView registerNib:[UINib nibWithNibName:@"financialProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"homepageReusedId6"];
    
    
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
        __weak HomepageViewController *weakself = self;
        cell.block = ^(){
            [weakself clickLoan];
        };
        cell.block1 = ^(){
            [weakself clickSelect];
        };
        cell.block2 = ^(){
            [weakself clickCredit];
        };
            return cell;
    }else if (indexPath.section==1){
        ActivityTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:self options:nil] lastObject];
        HomePictureModel * model =[[HomePictureModel alloc] init];
        model =HomePictureArray1[0];
        cell.model = model;
        return cell;

    }else if (indexPath.section==2){
        bankLoanTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"bankLoanTableViewCell" owner:self options:nil]  lastObject];
        return cell;
    }else if (indexPath.section==3){
        loaninfoModel * model = loaninfoData[indexPath.row];
        NSLog(@"%@",model);
        recommandLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if (indexPath.section==4){
        HotCardCommandViewCellTableViewCell * cell =  [[[NSBundle mainBundle] loadNibNamed:@"HotCardCommandViewCellTableViewCell" owner:self options:nil] lastObject];
        HomePictureModel * model = [[HomePictureModel alloc] init];
        model = HomePictureArray2[0];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else if (indexPath.section==5){
        financialSelectedTableViewCell * cell =  [[[NSBundle mainBundle] loadNibNamed:@"financialSelectedTableViewCell" owner:self options:nil] lastObject];
        return cell;

    }else if (indexPath.section==6){
        gfselectModel * model = selectData[indexPath.row];
        
        financialProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homepageReusedId6" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0||section==1||section==2||section==4||section==5) {
        return 10;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0||indexPath.section==1||indexPath.section==3) {
        return 106;
    }else if (indexPath.section ==  4){
        return 230;
    }
    
    else if (indexPath.section==2||indexPath.section==5){
        return 44;
    }else if (indexPath.section==6){
        
        return 132;
    }
    else{
        return 200;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        /**
         *  跳到全部贷款页面
         */
        [self performSegueWithIdentifier:@"loanSegue" sender:nil];
    
    }
    
    
    if (indexPath.section==3) {
        loaninfoModel * model = loaninfoData[indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        HomeDetailViewController * vc = [[HomeDetailViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.uid = model.loanId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==5){
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
        SelectProductViewController * vc = (SelectProductViewController*)[storyboard instantiateViewControllerWithIdentifier:@"SELECT"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (indexPath.section==6){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        gfselectModel * model = selectData[indexPath.row];
        SelectProductDetailViewController * VC = [[SelectProductDetailViewController alloc] init];
        VC.uid = model.selectId;
        VC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:VC animated:YES];
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
 
    self.navigationItem.rightBarButtonItems = buttonItems;
}
- (void)cityAct:(id)sender{
    
}

/**
 *  点击贷款按钮
 */
- (void)clickLoan
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
   FormuViewController *VC = (FormuViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MoreLoan"];
    [self.navigationController pushViewController:VC animated:YES];

}

- (void)clickCredit
{
    [self showHint:@"页面建设中"];
}

- (void)clickSelect
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
    SelectProductViewController * vc = (SelectProductViewController*)[storyboard instantiateViewControllerWithIdentifier:@"SELECT"];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  点击头部滚动视图
 *
 *  @param cycleScrollView <#cycleScrollView description#>
 *  @param index           <#index description#>
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
    BannerDetailViewController *VC = (BannerDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Banner"];
  adverModel *model = [imageArray objectAtIndex:index];
    
    VC.bannerUrl = model.link;
    [self.navigationController pushViewController:VC animated:YES];
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
