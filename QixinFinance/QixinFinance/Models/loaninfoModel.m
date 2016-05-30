//
//  loaninfoModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "loaninfoModel.h"

@implementation loaninfoModel
- (id)initWithloanId:(NSString*)loanId imgthumb:(NSString*)imgthumb mrate:(NSString*)mrate name:(NSString*)name number:(NSString*)number
{
    loaninfoModel * model = [[loaninfoModel alloc] init];
    model.loanId = loanId;
    model.imgthumb = imgthumb;
    model.mrate = mrate;
    model.name = name;
    model.number = number;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * loaninfoArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * loanId = dict[@"id"];
        NSString * imgthumb = dict[@"imgthumb"];
        NSString * mrate = dict[@"mrate"];
        NSString * name = dict[@"name"];
        NSString * number = dict[@"number"];
        loaninfoModel * model = [[loaninfoModel alloc] initWithloanId:loanId imgthumb:imgthumb mrate:mrate name:name number:number];
        [loaninfoArray addObject:model];
    }
    return loaninfoArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
