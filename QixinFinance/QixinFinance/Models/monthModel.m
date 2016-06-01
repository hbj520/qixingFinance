//
//  monthModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "monthModel.h"

@implementation monthModel
- (id)initWithmonth:(NSString *)month value:(NSString *)value
{
    monthModel * model = [[monthModel alloc] init];
    model.month = month;
    model.value = value;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * monthArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * month = dict[@"month"];
        NSString * value = dict[@"value"];
        monthModel * model = [[monthModel alloc] initWithmonth:month value:value];
        [monthArray addObject:model];
    }
    return monthArray;
}

@end
