//
//  loaninfoModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loaninfoModel : NSObject
@property(nonatomic,copy)NSString * loanId;
@property(nonatomic,copy)NSString * imgthumb;
@property(nonatomic,copy)NSString * mrate;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString * number;
- (id)initWithloanId:(NSString*)loanId imgthumb:(NSString*)imgthumb mrate:(NSString*)mrate name:(NSString*)name number:(NSString*)number;
- (NSMutableArray *)buildWithData:(NSArray *)data;
@end
