//
//  FirstStyleTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "FirstStyleTableViewCell.h"
#import "JobInfoCollectionViewCell.h"
#import "JobInfoModel.h"
#import "MyAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation FirstStyleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
    UICollectionViewFlowLayout * _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _flowLayout.minimumInteritemSpacing = 50;
    _flowLayout.minimumLineSpacing = 10;
    _flowLayout.itemSize = CGSizeMake((ScreenWidth)/5, 85);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.collectionViewLayout = _flowLayout;
    
    UINib *cellNib = [UINib nibWithNibName:@"JobInfoCollectionViewCell" bundle:[NSBundle mainBundle]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cell"];
    _collectionView.bounces = NO;
    _collectionView.scrollEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO; //指士条
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self loadData];
    }

- (void)loadData
{
    [[MyAPI sharedAPI]  getJobInfoWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
        if (success) {
            dataSource = arrays;
            JobInfoModel * model = arrays[1];
            NSLog(@"%@",model.jobname);
            [self.collectionView reloadData];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JobInfoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    JobInfoModel * model = [[JobInfoModel alloc] init];
    model =  dataSource[indexPath.item];
    cell.jobname.text = model.jobname;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.thumbimg] placeholderImage:[UIImage imageNamed:@"peopleLoan"]];
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.input endEditing:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
