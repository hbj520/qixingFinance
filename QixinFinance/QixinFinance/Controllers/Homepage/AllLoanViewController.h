//
//  AllLoanViewController.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
/**
 *  筛选框特有的button类
 */



@interface AllLoanViewController : BaseViewController

@property(nonatomic,copy)NSString * sort;//筛选id

@property(nonatomic,copy)NSString * jtype;//工作类型id

@property(nonatomic,copy)NSString * mtype;//抵押类型id

@property(nonatomic,copy)NSString * rtype;//还款类型id

@property(nonatomic,copy)NSString * btype;//机构类型id

@property(nonatomic,copy)NSString * month;//时间id

@property(nonatomic,copy)NSString * money;//金额id

@property(nonatomic,copy)NSString * page;//页数

@property (nonatomic,copy)NSString *fastMoney;//快速贷款金额

@end
