//
//  adverModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/5/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "adverModel.h"

@implementation adverModel
- (id)initWithLink:(NSString *)link imageurl:(NSString *)imageurl adName:(NSString*)adName adId:(NSString*)adId
{
    adverModel * model = [[adverModel alloc] init];
    model.link = link;
    model.adimageUrl = imageurl;
    model.adName = adName;
    model.adId = adId;
    return model;
}

- (NSMutableArray *)buildData:(NSDictionary *)data
{
    NSMutableArray *bannerArray = [NSMutableArray array];
    NSString * adId = data[@"id"];
    NSString *imageurl = data[@"imgthumb"];
    NSString * link = data[@"link"];
    NSString *name = data[@"name"];
    adverModel * model = [[adverModel alloc] initWithLink:link imageurl:imageurl adName:name adId:adId];
    [bannerArray addObject:model];
    return bannerArray;
}

@end
