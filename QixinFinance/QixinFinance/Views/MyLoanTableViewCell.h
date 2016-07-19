//
//  MyLoanTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLoanModel.h"

@interface MyLoanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UILabel *myloanname;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *mrate;
@property (weak, nonatomic) IBOutlet UILabel *deadline;
@property (weak, nonatomic) IBOutlet UILabel *rtype;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet UILabel *ctime;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property(nonatomic,strong)MyLoanModel * model;
@end
