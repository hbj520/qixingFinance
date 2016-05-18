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
static NSString *cellReuseId = @"cellId";
@interface ThreeTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    UICollectionView *_collectionView;
}


@end
