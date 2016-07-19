//
//  recommandLoanTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "recommandLoanTableViewCell.h"
#import "Tools.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation recommandLoanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
- (void)setModel:(loaninfoModel *)model
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imgthumb] placeholderImage:[UIImage imageNamed:@"smallimage"]];
    NSString * percentNum = [NSString stringWithFormat:@"%@%%",model.mrate];
    self.percentNum.text = percentNum;
    //self.applyCount.text = model.number.stringValue;
  
   // self.applyCount.text = model.number.stringValue;
int applycount = [model.number intValue];
    if(applycount>=1000){
      NSString * apply = [Tools countNumAndChangeformat:model.number.stringValue];
        self.applyCount.text = apply;
    }else{
    self.applyCount.text = [NSString stringWithFormat:@"%d",applycount];
    }
    self.titleLabel.text = model.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

@end
