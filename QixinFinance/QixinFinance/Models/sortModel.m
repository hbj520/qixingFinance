//
//  sortModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "sortModel.h"

@implementation sortModel
- (id)initWithname:(NSString *)name sort:(NSString *)sort
{
    sortModel * model = [[sortModel alloc] init];
    model.name = name;
    model.sort = sort;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * sortArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * name = dict[@"name"];
        NSString * sort = dict[@"sort"];
        sortModel * model = [[sortModel alloc] initWithname:name sort:sort];
        [sortArray addObject:model];
    }
    return sortArray;
}


@end
