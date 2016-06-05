//
//  selectView.h
//  select
//
//  Created by GBH-MAC on 16/2/4.
//  Copyright © 2016年 GBH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^transIndexBlock)(NSInteger index);
typedef void (^selectViewBlock1)(NSString * str1,NSString * str2,NSString * str3,NSString * str4);
@interface selectView : UIView

@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,copy)NSString * jtype;
@property(nonatomic,copy)NSString * btype;
@property(nonatomic,copy)NSString *rtype;
@property(nonatomic,copy)NSString * mtype;
@property(nonatomic,copy)selectViewBlock1 block;
-(id)initWithFrame:(CGRect)frame;
@end
