//
//  LoanInfoTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LoanInfoTableViewCell.h"
#import "Tools.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation LoanInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(moreloaninfoModel *)model
{
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.thumbimg] placeholderImage:[UIImage imageNamed:@"smallimage"]];
    self.name.text = model.name;
    int applycount = [model.number intValue];
    if(applycount>=1000){
   NSString * apply  = [Tools countNumAndChangeformat:model.number.stringValue];
        self.applyCount.text = apply;
    }else{
    self.applyCount.text = [NSString stringWithFormat:@"%d",applycount];
    }
    NSString * percentNum = [NSString stringWithFormat:@"%@%%",model.mrate];
    self.precentNum.text = percentNum;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
