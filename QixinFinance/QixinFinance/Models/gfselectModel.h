//
//  gfselectModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gfselectModel : NSObject
@property(nonatomic,copy)NSString *deadline;
@property(nonatomic,copy)NSString *earnings;
@property(nonatomic,copy)NSString * selectId;
@property(nonatomic,copy)NSString *imgthumb;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString * url;

@property(nonatomic,copy)NSString *comment;

- (id)initWithParameter:(NSString *)selectId  deadline:(NSString *)deadline earnings:(NSString*)earnings imgthumb:(NSString *)imgthumb selectname:(NSString *)selectname selecturl:(NSString*)selecturl comment:(NSString *)comment;
- (NSMutableArray *)buildWithData:(NSArray *)data;

@end
