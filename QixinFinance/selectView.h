//
//  selectView.h
//  select
//
//  Created by GBH-MAC on 16/2/4.
//  Copyright © 2016年 GBH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^transIndexBlock)(NSInteger index);
@interface selectView : UIView
@property (strong,nonatomic) UINavigationController *myNav;
-(id)initWithFrame:(CGRect)frame;

@end
