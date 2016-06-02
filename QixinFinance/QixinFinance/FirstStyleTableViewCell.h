//
//  FirstStyleTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstStyleTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * dataSource;
}
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
