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


- (NSMutableArray *)buildData:(NSArray *)data
{
    NSMutableArray *bannerArray = [NSMutableArray array];
    for(NSDictionary * dict in data){
    NSString * adId = dict[@"id"];
    NSString *imageurl = dict[@"imgthumb"];
    NSString * link = dict[@"link"];
    NSString *name = dict[@"name"];
    adverModel * model = [[adverModel alloc] initWithLink:link imageurl:imageurl adName:name adId:adId];
         [bannerArray addObject:model];
    }
   
    return bannerArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
