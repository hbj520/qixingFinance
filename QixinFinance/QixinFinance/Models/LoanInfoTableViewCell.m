//
//  LoanInfoTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LoanInfoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation LoanInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(moreloaninfoModel *)model
{
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.thumbimg]];
    self.name.text = model.name;
    int applycount = [model.number intValue];
    self.applyCount.text = [NSString stringWithFormat:@"%d",applycount];
    self.precentNum.text = model.mrate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
