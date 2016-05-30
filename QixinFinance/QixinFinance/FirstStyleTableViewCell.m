//
//  FirstStyleTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "FirstStyleTableViewCell.h"

@implementation FirstStyleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.btnmort addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
     [self.btnwork addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
     [self.btnloanpeople addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
     [self.btncredit addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick
{
    self.block();
    NSLog(@"bug");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.input endEditing:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
