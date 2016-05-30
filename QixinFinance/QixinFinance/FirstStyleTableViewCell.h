//
//  FirstStyleTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickBtn)();
@interface FirstStyleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIButton *btnwork;
@property (weak, nonatomic) IBOutlet UIButton *btnloanpeople;
@property (weak, nonatomic) IBOutlet UIButton *btnmort;
@property (weak, nonatomic) IBOutlet UIButton *btncredit;
@property(nonatomic,copy)clickBtn block;
@end
