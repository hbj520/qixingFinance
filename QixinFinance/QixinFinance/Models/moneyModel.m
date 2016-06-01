//
//  moneyModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "moneyModel.h"

@implementation moneyModel
- (id)initWithmoney:(NSString*)money value:(NSString*)value
{
    moneyModel * model = [[moneyModel alloc] init];
    model.money = money;
    model.value = value;
    return model;
}

- (NSMutableArray*)buildWithData:(NSArray *)data
{
    NSMutableArray * moneyArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * money = dict[@"money"];
        NSString * value = dict[@"value"];
        moneyModel * model = [[moneyModel alloc] initWithmoney:money value:value];
        [moneyArray addObject:model];
    }
    return moneyArray;
}

@end
