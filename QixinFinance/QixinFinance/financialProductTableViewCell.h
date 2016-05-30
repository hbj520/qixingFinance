//
//  financialProductTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gfselectModel.h"
@interface financialProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *precentNum;
@property (weak, nonatomic) IBOutlet UILabel *monthNum;
@property(nonatomic,strong) gfselectModel * model;
@end
