//
//  selectViewTableViewCell.h
//  select
//
//  Created by GBH-MAC on 16/2/4.
//  Copyright © 2016年 GBH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectViewBlock)(NSString * str1,NSString * str2,NSString * str3,NSString * str4);
@interface selectViewTableViewCell : UITableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,assign) NSInteger i ;
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,copy)NSString * jtype;
@property(nonatomic,copy)NSString * btype;
@property(nonatomic,copy)NSString *rtype;
@property(nonatomic,copy)NSString * mtype;
-(void)setCollectionView;
@property(nonatomic,copy)selectViewBlock block;
@end
