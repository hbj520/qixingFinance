//
//  LoanInfoTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "moreloaninfoModel.h"
@interface LoanInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *applyCount;
@property (weak, nonatomic) IBOutlet UILabel *precentNum;
@property(nonatomic,strong) moreloaninfoModel * model;
@end
