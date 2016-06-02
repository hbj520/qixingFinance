//
//  JobInfoModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/2.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobInfoModel : NSObject
@property(nonatomic,copy)NSString * jobid;
@property(nonatomic,copy)NSString * jobname;
@property(nonatomic,copy)NSString * thumbimg;

- (id)initWithjobid:(NSString*)jobid name:(NSString*)name thumbimg:(NSString*)thumbimg;
- (JobInfoModel*)buildWithData:(NSDictionary*)data;
@end
