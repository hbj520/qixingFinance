//
//  MyLoanModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyLoanModel.h"

@implementation MyLoanModel

- (id)initWithUid:(NSString *)uid name:(NSString *)name imgthumb:(NSString *)imgthumb money:(NSString *)money mrate:(NSString *)mrate dealine:(NSString *)deadline rtype:(NSString *)rtype status:(NSString *)status reason:(NSString *)reason ctime:(NSString *)ctime
{
    MyLoanModel * model = [[MyLoanModel alloc] init];
    model.uid = uid;
    model.deadline = deadline;
    model.mrate = mrate;
    model.rtype = rtype;
    model.name = name;
    model.imgthumb = imgthumb;
    model.money = money;
    model.status = status;
    model.reason =reason;
    model.ctime = ctime;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * myloanArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * uid = dict[@"id"];
        NSString * name = dict[@"name"];
        NSString * imgthumb = dict[@"thumbimg"];
        NSString * money = dict[@"money"];
        NSString * mrate = dict[@"mrate"];
        NSString * deadline = dict[@"deadline"];
        NSString * rtype = dict[@"rtype"];
        NSString * status = dict[@"status"];
        NSString * reason = dict[@"reason"];
        NSString * ctime = dict[@"ctime"];
        MyLoanModel * model = [[MyLoanModel alloc] initWithUid:uid name:name imgthumb:imgthumb money:money mrate:mrate dealine:deadline rtype:rtype status:status reason:reason ctime:ctime];
        [myloanArray addObject:model];
    }
    return myloanArray;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
