//
//  JobInfoModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/2.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JobInfoModel.h"

@implementation JobInfoModel
- (id)initWithjobid:(NSString *)jobid name:(NSString *)name thumbimg:(NSString *)thumbimg
{
    JobInfoModel * model = [[JobInfoModel alloc] init];
    model.jobid = jobid;
    model.jobname = name;
    model.thumbimg = thumbimg;
    return model;
}

- (JobInfoModel*)buildWithData:(NSDictionary *)data
{
    NSString * jobid = data[@"id"];
    NSString * name = data[@"name"];
    NSString * thumbimg = data[@"thumbimg"];
    JobInfoModel * model = [[JobInfoModel alloc] initWithjobid:jobid name:name thumbimg:thumbimg];
    return model;
}

@end
