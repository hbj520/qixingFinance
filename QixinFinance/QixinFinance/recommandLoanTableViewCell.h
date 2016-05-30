//
//  recommandLoanTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loaninfoModel.h"
@interface recommandLoanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyCount;
@property (weak, nonatomic) IBOutlet UILabel *percentNum;
@property(nonatomic,strong) loaninfoModel * model;
@end
