//
//  ZHlookHouseSmarFourCell.h
//  Zoharo
//
//  Created by GBH-MAC on 16/1/13.
//  Copyright © 2016年 Coelong. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZHlookHouseSmarFourCell : UICollectionViewCell
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)NSString *name;
@property(nonatomic,assign)BOOL  inx;
- (void)setSelected:(BOOL)selected;
@end
