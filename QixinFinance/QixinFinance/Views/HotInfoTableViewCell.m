//
//  HotInfoTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HotInfoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation HotInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(InfoCateModel *)model
{
    [self.thumbImg sd_setImageWithURL:[NSURL URLWithString:model.imgthumb] placeholderImage:[UIImage imageNamed:@"smallimage"]];
    self.newsTitle.text = model.title;
    self.ctime.text = model.ctime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
