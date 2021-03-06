//
//  ThreeTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ThreeTableViewCell.h"
#import "FormuViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation ThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        [self initContentView];//初始化
    }
    return self;
}
#pragma mark - PrivateMethod
- (void)initContentView{
    //self.backgroundColor = [UIColor redColor];
    //初始化自定义的layout
    UICollectionViewFlowLayout * _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.itemSize = CGSizeMake((ScreenWidth)/3, 106);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 106) collectionViewLayout:_flowLayout];
    //注册cell
    UINib *cellNib = [UINib nibWithNibName:@"ThreeCollectionViewCell" bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:cellReuseId];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.bounces = NO;
    _collectionView.scrollEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO; //指士条
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * imgArray = @[@"loan",@"credict",@"finance"];
    NSArray * nameArray = @[@"贷 款",@"信用卡",@"理 财"];
    NSArray * detailArray = @[@"急需看这里",@"快乐生活看这里",@"赚钱看这里"];
    //重用cell
    ThreeCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellReuseId forIndexPath:indexPath];
    if(indexPath.item == 2){
        cell.line.hidden = YES;
    }
    cell.imgView.image = [UIImage imageNamed:imgArray[indexPath.item]];
    if(ScreenWidth == 320){
        cell.name.font = [UIFont systemFontOfSize:14];
        cell.detail.font = [UIFont systemFontOfSize:6];
    }
    cell.name.text = nameArray[indexPath.item];
    cell.detail.text = detailArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.item);
    if (indexPath.item==0) {
    self.block();
    }else if (indexPath.item==2){
        self.block1();
    }else{
        self.block2();
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
