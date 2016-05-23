//
//  PersonViewController.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PersonViewController.h"
#import "UINavigationBar+Awesome.h"
#import "UIImage+ImageEffects.h"
#define NAVBAR_CHANGE_POINT 50

@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>
{
    UIImagePickerController *_picker;
    BOOL _isIcon;//标记是否选择为头像
    NSArray * imgArray;
    NSArray*descArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UIImageView *name;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imgArray = @[@"PersonProgressSearch",@"PersonEditingLoanInfo",@"PersonCreditCard",@"PersonManageFinical",@"PersonSetting"];
    descArray = @[@"贷款进度查询",@"完善贷款资料",@"信用卡还款提醒",@"我的理财",@"设置"];
    self.tableView.dataSource = self;

  }

- (void)tapBackImg:(UIGestureRecognizer *)ges{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从相册选取", nil];
    sheet.tag = 100;
    [sheet showInView:self.view];
}
- (void)tapIconAct:(UIGestureRecognizer *)ges{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从相册选取", nil];
    sheet.tag = 101;
    [sheet showInView:self.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {
        _isIcon = NO;
    }else{
        _isIcon = YES;
    }
    if (buttonIndex == 0) {//相机选取
        [self openCamera];
    }else if(buttonIndex == 1){//照片选取
        [self openPhotoAlbum];
    }else{
        return;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.headIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *TapIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconAct:)];
    [self.headIcon addGestureRecognizer:TapIcon];
    [self initPickView];
    self.backGroundImage.userInteractionEnabled = YES;
    UIImage * backImg = [UIImage imageNamed:@"PersonBackGroundIcon"];
    UIImage * backImage = [backImg applyLightEffect];
    self.backGroundImage.image = backImage;
    UITapGestureRecognizer *TapBackImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackImg:)];
    [self.backGroundImage addGestureRecognizer:TapBackImg];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

- (void)initPickView{
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}

- (void)openPhotoAlbum{
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_picker animated:YES completion:nil];
}
- (void)openCamera{
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_picker animated:YES completion:nil];
}
#pragma mark UITableViewDatasource



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else{
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section==0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
        UIImageView * imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(25,8, 35,30)];
        imgView.image = [UIImage imageNamed: imgArray[indexPath.row]];
        UILabel * descLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 8, 200, 29)];
        descLab.textColor = [UIColor blackColor];
        descLab.font = [UIFont systemFontOfSize:17];
        descLab.text = descArray[indexPath.row];
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:imgView];
        [cell.contentView addSubview:descLab];
        return cell;
    }else if (indexPath.section==1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
        UIImageView * imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(25, 8, 35, 25)];
        imgView.image = [UIImage imageNamed: imgArray[2]];
        UILabel * descLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 8, 200, 29)];
        descLab.textColor = [UIColor blackColor];
        descLab.font = [UIFont systemFontOfSize:17];
        descLab.text = descArray[2];
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:imgView];
        [cell.contentView addSubview:descLab];
        return cell;
    }else if (indexPath.section==2){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];

        UIImageView * imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(25, 8, 35, 25)];
        imgView.image = [UIImage imageNamed: imgArray[3]];
        UILabel * descLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 8, 200, 29)];
        descLab.textColor = [UIColor blackColor];
        descLab.font = [UIFont systemFontOfSize:17];
        descLab.text = descArray[3];
        UILabel * labelright = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) - 140, 10, 120, 25)];
        labelright.textColor = [UIColor colorWithRed:138/255.0 green:139/255.0 blue:140/255.0 alpha:100];
        labelright.font = [UIFont systemFontOfSize:13];
        labelright.text = @"昨日收益 0.00元";
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:labelright];
        [cell.contentView addSubview:imgView];
        [cell.contentView addSubview:descLab];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
        UIImageView * imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(25, 8, 35, 25)];
        imgView.image = [UIImage imageNamed: imgArray[4]];
        UILabel * descLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 8, 200, 29)];
        descLab.textColor = [UIColor blackColor];
        descLab.font = [UIFont systemFontOfSize:17];
        descLab.text = descArray[4];
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:imgView];
        [cell.contentView addSubview:descLab];

        
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark -- 写跳转控制器的地方
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = indexPath.section * 10 + indexPath.row;
    switch (i) {
        case 0:
        {
            
        }
            break;
            case 1:
        {
            
        }
            break;
            
            case 10:
        {
            
        }
            break;
            case 20:
        {
            
        }
            break;
            
            case 30:
        {
            
        }
            break;
              default:
            break;
    }
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
