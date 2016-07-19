//
//  InfoCateModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "InfoCateModel.h"

@implementation InfoCateModel
- (id)initWithParameter:(NSString *)articleid title:(NSString *)title catename:(NSString *)catename imgthumb:(NSString *)imgthumb ctime:(NSString *)ctime
{
    InfoCateModel * model = [[InfoCateModel alloc] init];
    model.articleid = articleid;
    model.title = title;
    model.catename = catename;
    model.imgthumb = imgthumb;
    model.ctime = ctime;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * InfoModelArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
        NSString * articleid = dict[@"articleid"];
        NSString * title = dict[@"title"];
        NSString * catename = dict[@"catename"];
        NSString * imgthumb = dict[@"imgthumb"];
        NSString * ctime = dict[@"ctime"];
        InfoCateModel * model = [[InfoCateModel alloc] initWithParameter:articleid title:title catename:catename imgthumb:imgthumb ctime:ctime];
        [InfoModelArray addObject:model];
    }
    return InfoModelArray;
}

@end
