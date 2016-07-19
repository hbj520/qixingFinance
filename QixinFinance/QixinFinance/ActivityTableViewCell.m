//
//  ActivityTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setModel:(HomePictureModel *)model
{
        [self.Img sd_setImageWithURL:[NSURL URLWithString:model.imgthumb] placeholderImage:[UIImage imageNamed:@"smallimage"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
