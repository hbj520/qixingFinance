//
//  MyLoanModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLoanModel : NSObject
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * imgthumb;
@property(nonatomic,copy)NSString * money;
@property(nonatomic,copy)NSString * mrate;
@property(nonatomic,copy)NSString * deadline;
@property(nonatomic,copy)NSString * rtype;
@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * reason;
@property(nonatomic,copy)NSString * ctime;

- (id)initWithUid:(NSString *)uid name:(NSString *)name imgthumb:(NSString*)imgthumb money:(NSString*)money mrate:(NSString*)mrate dealine:(NSString*)deadline rtype:(NSString*)rtype status:(NSString*)status reason:(NSString*)reason ctime:(NSString*)ctime;

- (NSMutableArray *)buildWithData:(NSArray*)data;

@end
