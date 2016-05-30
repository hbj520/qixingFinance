//
//  gfselectModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "gfselectModel.h"

@implementation gfselectModel
- (id)initWithParameter:(NSString *)selectId  deadline:(NSString *)deadline earnings:(NSString*)earnings imgthumb:(NSString *)imgthumb selectname:(NSString *)selectname
{
    gfselectModel * model = [[gfselectModel alloc] init];
    model.selectId = selectId;
    model.deadline = deadline;
    model.earnings = earnings;
    model.imgthumb = imgthumb;
    model.name = selectname;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * selectArray = [NSMutableArray array];
    for (NSDictionary * dict in data) {
        NSString * selectId = dict[@"id"];
        NSString *deadline = dict[@"deadline"];
        NSString * earnings = dict[@"earnings"];
        NSString *imgthumb = dict[@"imgthumb"];
        NSString * name = dict[@"name"];
        gfselectModel * model = [[gfselectModel alloc] initWithParameter:selectId deadline:deadline earnings:earnings imgthumb:imgthumb selectname:name];
        [selectArray addObject:model];
        
    }
    return selectArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
