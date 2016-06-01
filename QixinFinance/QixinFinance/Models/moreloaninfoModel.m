//
//  moreloaninfoModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "moreloaninfoModel.h"

@implementation moreloaninfoModel

- (id)initWithinfoId:(NSString *)infoId mrate:(NSString *)mrate name:(NSString *)name number:(NSNumber *)number thumbimg:(NSString *)thumbimg
{
    moreloaninfoModel * model = [[moreloaninfoModel alloc] init];
    model.infoId = infoId;
    model.mrate = mrate;
    model.name = name;
    model.number = number;
    model.thumbimg = thumbimg;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * moreloaninfoArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * infoId = dict[@"id"];
        NSString * mrate = dict[@"mrate"];
        NSString * name = dict[@"name"];
        NSNumber * number = dict[@"number"];
        NSString * thumbimg = dict[@"thumbimg"];
        moreloaninfoModel * model = [[moreloaninfoModel alloc] initWithinfoId:infoId mrate:mrate name:name number:number thumbimg:thumbimg];
        [moreloaninfoArray addObject:model];
    }
    return moreloaninfoArray;
}

@end
