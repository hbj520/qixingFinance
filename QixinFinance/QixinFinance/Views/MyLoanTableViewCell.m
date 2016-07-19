//
//  MyLoanTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyLoanTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MyLoanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MyLoanModel *)model
{
   [self.thumbImg sd_setImageWithURL:[NSURL URLWithString:model.imgthumb] placeholderImage:[UIImage imageNamed:@"smallimage"]];
    self.myloanname.text = model.name;
    NSString * money = [NSString stringWithFormat:@"%@",model.money];
    self.money.text = money;
    NSString * mrate = [NSString stringWithFormat:@"%@%%",model.mrate];
   self.mrate.text = mrate;
    NSString * deadline = [NSString stringWithFormat:@"%@",model.deadline];
  self.deadline.text = deadline;
    if([model.reason isKindOfClass:[NSNull class]]){
        self.reason.text = @"";
    }else{
        self.reason.text = model.reason;
    }
    
  //  self.rtype.text = model.rtype;
    self.status.text = model.status;
 //   self.reason.text = model.reason;
    self.ctime.text = model.ctime;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
