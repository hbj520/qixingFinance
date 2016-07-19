//
//  HotCardCommandViewCellTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePictureModel.h"
@interface HotCardCommandViewCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property(nonatomic,strong)HomePictureModel * model;
@end
