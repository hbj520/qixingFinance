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
#import "typelistModel.h"
#import "Config.h"
@interface selectViewTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSArray *indexAry;
    NSInteger kk;
    NSInteger index;
   
    NSArray * dataSource;
    NSString * kkk;
}

@property(strong,nonatomic)UICollectionView *collectionView;
@end

@implementation selectViewTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        kk= 100000;
       
        [self setCollectionView];
    }
    return self;
}

-(void)setCollectionView{
    
    indexAry = self.array;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.contentView.frame.size.height) collectionViewLayout:layout];
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
    
    typelistModel * model = [[[indexAry objectAtIndex:0] objectForKey:@"num"] objectAtIndex:indexPath.row] ;
    [myBig setName:model.dname];
     _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, ([[[indexAry objectAtIndex:0]objectForKey:@"num"] count]/4 + [[[indexAry objectAtIndex:0]objectForKey:@"num"] count]%4) * 40);
       return myBig;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.frame.size.width - 60)/4, 30);
}
// 设置每个cell上下左右相距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}


#pragma mark -- 筛选传值
/**
 *  当选中时候可以传递一个listid
 *
 *  @param collectionView
 *  @param indexPath
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    kk=indexPath.row;
   
    typelistModel * model = [[typelistModel alloc] init];
    
      model = [[indexAry objectAtIndex:0]objectForKey:@"num"][kk];
    
    
   NSLog(@"%@,%@",model.fromname, model.listid);
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    /**
     *  4是职业类型
        3是还款方式
        5是机构类型
        2是抵押类型
     */
    if ([model.fromname isEqualToString:@"4"]) {
        self.jtype = model.listid;
        [defaults removeObjectForKey:@"4"];
        [defaults setObject:model.listid forKey:@"4"];
        [defaults synchronize];
    }else if ([model.fromname isEqualToString:@"3"]){
        self.rtype = model.listid;
        [defaults removeObjectForKey:@"3"];
        [defaults setObject:model.listid forKey:@"3"];
        [defaults synchronize];
    }else if ([model.fromname isEqualToString:@"5"]){
        self.btype = model.listid;
        [defaults removeObjectForKey:@"5"];
        [defaults setObject:model.listid forKey:@"5"];
        [defaults synchronize];
    }else{
        self.mtype = model.listid;
        [defaults removeObjectForKey:@"2"];
        [defaults setObject:model.listid forKey:@"2"];
        [defaults synchronize];
    }
 
    self.block(self.jtype,self.btype,self.mtype,self.rtype);

 //   [_collectionView reloadData];
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
