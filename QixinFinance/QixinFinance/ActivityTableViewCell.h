//
//  ActivityTableViewCell.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePictureModel.h"
@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Img;
@property(nonatomic,strong)HomePictureModel * model;
@end
