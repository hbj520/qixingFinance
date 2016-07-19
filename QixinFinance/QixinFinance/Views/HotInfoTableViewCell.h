//
//  HotInfoTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoCateModel.h"
@interface HotInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *ctime;
@property(nonatomic,copy)InfoCateModel * model;
@end
