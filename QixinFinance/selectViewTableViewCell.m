//
//  selectViewTableViewCell.m
//  select
//
//  Created by GBH-MAC on 16/2/4.
//  Copyright © 2016年 GBH-MAC. All rights reserved.
//

#import "selectViewTableViewCell.h"
#import "ZHlookHouseSmarFourCell.h"
#import "selectView.h"
@interface selectViewTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSArray *indexAry;
    NSInteger kk;
    NSInteger index;
    NSArray * dataSource;
}

@property(strong,nonatomic)UICollectionView *collectionView;
@end

@implementation selectViewTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        kk= 100000;
       
       // [self setCollectionView];
    }
    return self;
}
-(void)setCollectionView{
    dataSource = @[[NSArray arrayWithObjects:@{@"num":@[@"不限",@"上班族",@"企业主",@"个体户",@"学生",@"自由职业"]}, nil],[NSArray arrayWithObjects:@{@"num":@[@"不限",@"车辆抵押",@"房产抵押",@"其他抵押",@"信用卡",@"担保"]}, nil],[NSArray arrayWithObjects:@{@"num":@[@"不限",@"分期还款",@"到期还款",@"随借随还"]}, nil],[NSArray arrayWithObjects:@{@"num":@[@"不限",@"银行",@"小贷公司",@"典当行"]}, nil]];
    
    
    indexAry = dataSource[self.i];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,60) collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[ZHlookHouseSmarFourCell class] forCellWithReuseIdentifier:@"Four"];

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[[indexAry objectAtIndex:0]objectForKey:@"num"] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHlookHouseSmarFourCell *myBig = nil;
    if (!myBig) {
        myBig = [collectionView dequeueReusableCellWithReuseIdentifier:@"Four" forIndexPath:indexPath];
    }

    [myBig setName:[[[indexAry objectAtIndex:0]objectForKey:@"num"]objectAtIndex:indexPath.row]];
//    if (indexPath.row == [[[indexAry objectAtIndex:0]objectForKey:@"num"] count] - 1) {
//    }
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, ([[[indexAry objectAtIndex:0]objectForKey:@"num"] count]/4 + [[[indexAry objectAtIndex:0]objectForKey:@"num"] count]%4) * 40);
    
    if (kk == indexPath.row) {
        index++;
        if (1) {
            myBig.nameLabel.backgroundColor = [UIColor colorWithRed:122/255.0 green:142/255.0 blue:182/255.0 alpha:1];
            myBig.nameLabel.textColor = [UIColor whiteColor];
        }else{
       // myBig.nameLabel.backgroundColor = [UIColor colorWithRed:122/255.0 green:142/255.0 blue:182/255.0 alpha:1];
       myBig.nameLabel.textColor = [UIColor blackColor];
        }
    }else{
        myBig.nameLabel.textColor = [UIColor blackColor];
    }
    return myBig;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.frame.size.width - 60)/4, 30);
}
// 设置每个cell上下左右相距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    kk=indexPath.row;
    
    NSLog(@"%ld",indexPath.item);
    [_collectionView reloadData];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
// 设置是否允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
