//
//  selectViewTableViewCell.h
//  select
//
//  Created by GBH-MAC on 16/2/4.
//  Copyright © 2016年 GBH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectViewTableViewCell : UITableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,assign) NSInteger i ;
@property(nonatomic,strong)NSMutableArray * array;

-(void)setCollectionView;

@end
