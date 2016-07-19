//
//  SecondTableViewCell.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSString *urlString = [NSString stringWithFormat:@"http://60.173.235.34:9090/qixin/app/nos_qx_loanlist"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];

}
- (IBAction)goback:(id)sender {
    if (self.webView.canGoBack)
    {
        [self.webView goBack];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
