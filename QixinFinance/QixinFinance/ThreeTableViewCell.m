//
//  ThreeTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ThreeTableViewCell.h"

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
    _flowLayout.minimumInteritemSpacing = 12;
    _flowLayout.minimumLineSpacing = 10;
    _flowLayout.itemSize = CGSizeMake((ScreenWidth-30)/3, 106);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(12, 0, ScreenWidth, 106) collectionViewLayout:_flowLayout];
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
    //重用cell
    ThreeCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellReuseId forIndexPath:indexPath];
    
  
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
