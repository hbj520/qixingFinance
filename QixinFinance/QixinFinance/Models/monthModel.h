//
//  monthModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface monthModel : NSObject
@property(nonatomic,copy)NSString * month;
@property(nonatomic,copy)NSString * value;
- (id)initWithmonth:(NSString*)month value:(NSString*)value;
- (NSMutableArray*)buildWithData:(NSArray*)data;
@end
