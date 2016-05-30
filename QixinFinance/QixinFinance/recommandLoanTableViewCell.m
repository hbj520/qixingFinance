//
//  recommandLoanTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "recommandLoanTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation recommandLoanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(loaninfoModel *)model
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgthumb]];
    self.percentNum.text = model.mrate;
    //self.applyCount.text = model.number.stringValue;
  
   // self.applyCount.text = model.number.stringValue;
int applycount = [model.number intValue];
    self.applyCount.text = [NSString stringWithFormat:@"%d",applycount];
    self.titleLabel.text = model.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
