//
//  typelistModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/31.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "typelistModel.h"

@implementation typelistModel
- (id)initWithdname:(NSString *)dname listid:(NSString *)listid fromname:(NSString *)fromname
{
    typelistModel * model = [[typelistModel alloc] init];
    model.dname = dname;
    model.listid = listid;
    model.fromname = fromname;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray *  typelistArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * dname = dict[@"dname"];
        NSString * listid = dict[@"id"];
        NSString * fromname = dict[@"fromname"];
        typelistModel * model = [[typelistModel alloc] initWithdname:dname listid:listid fromname:fromname];
        [typelistArray addObject:model];
    }
    return typelistArray;
}

@end
