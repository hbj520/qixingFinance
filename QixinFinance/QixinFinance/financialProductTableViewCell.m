//
//  financialProductTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "financialProductTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation financialProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(gfselectModel *)model
{
    self.titleLabel.text = model.name;
    int time = model.deadline.intValue;
    NSString * month = [NSString stringWithFormat:@"%d",time/30];
    self.monthNum.text = month;
    self.precentNum.text = model.earnings;
    [self.Img sd_setImageWithURL:[NSURL URLWithString:model.imgthumb] placeholderImage:[UIImage imageNamed:@"managefinicalselectedicon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
