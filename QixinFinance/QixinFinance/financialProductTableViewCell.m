//
//  financialProductTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "financialProductTableViewCell.h"
#import "Tools.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation financialProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _comment.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:100];
    _commentLab.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:100];
   
}

-(void)setModel:(gfselectModel *)model
{
    self.titleLabel.text = model.name;
    int time = model.deadline.intValue;
    if(time>=1000){
      NSString * time = [Tools countNumAndChangeformat:model.deadline];
        self.monthNum.text = time;
    }else{
    NSString * month = [NSString stringWithFormat:@"%d",time];
    self.monthNum.text = month;
    }
    self.precentNum.text = model.earnings;
    [self.Img sd_setImageWithURL:[NSURL URLWithString:model.imgthumb] placeholderImage:[UIImage imageNamed:@"smallimage"]];
    NSString *commentStr = [NSString stringWithFormat:@"  %@",model.comment];
    self.comment.text = commentStr;
    self.comment.textColor = [UIColor colorWithRed:59.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:100];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
