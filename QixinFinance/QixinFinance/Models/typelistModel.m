//
//  typelistModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/31.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "typelistModel.h"

@implementation typelistModel
- (id)initWithdname:(NSString *)dname listid:(NSString *)listid
{
    typelistModel * model = [[typelistModel alloc] init];
    model.dname = dname;
    model.listid = listid;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray *  typelistArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * dname = dict[@"dname"];
        NSString * listid = dict[@"id"];
        typelistModel * model = [[typelistModel alloc] initWithdname:dname listid:listid];
        [typelistArray addObject:model];
    }
    return typelistArray;
}

@end
