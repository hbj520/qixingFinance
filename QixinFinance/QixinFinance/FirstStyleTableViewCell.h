//
//  FirstStyleTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JobInfoModel;
typedef void (^PushMoreLoanPage)(JobInfoModel * model);
typedef void (^FastLoanBlock)(NSString *);
@interface FirstStyleTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * dataSource;
}
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,copy)PushMoreLoanPage  block;
@property(nonatomic,copy)FastLoanBlock fastBlock;
@end
