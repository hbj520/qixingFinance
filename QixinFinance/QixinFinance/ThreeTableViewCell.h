//
//  ThreeTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreeCollectionViewCell.h"
#import "ThreeCollectionViewCell.h"
typedef void(^pushVC)();
typedef void (^pushSelect)();
static NSString *cellReuseId = @"cellId";
@interface ThreeTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    UICollectionView *_collectionView;
}
@property(nonatomic,copy)pushVC block;
@property(nonatomic,copy)pushSelect block1;
@end
