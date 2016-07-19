//
//  HomePictureModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePictureModel.h"

@implementation HomePictureModel

- (id)initWithUid:(NSString *)uid Imgthumb:(NSString *)imgthumb Link:(NSString *)link Title:(NSString *)title
{
    HomePictureModel * model = [[HomePictureModel alloc] init];
    model.uid = uid;
    model.imgthumb = imgthumb;
    model.link = link;
    model.title = title;
    return model;
}

- (NSMutableArray *)buildWithData:(NSArray *)data
{
    NSMutableArray * PictureArray = [NSMutableArray array];
    
    for(NSDictionary * dict in data){
        NSString * uid =dict[@"id"];
        NSString * imgthumb = dict[@"imgthumb"];
        NSString * link = dict[@"link"];
        NSString * title = dict[@"title"];
        HomePictureModel * model = [[HomePictureModel alloc] initWithUid:uid Imgthumb:imgthumb Link:link Title:title];
        [PictureArray addObject:model];
    }
    
    return PictureArray;
    
}

@end
