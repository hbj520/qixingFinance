//
//  sortModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sortModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * sort;
- (id)initWithname:(NSString*)name sort:(NSString*)sort;
- (NSMutableArray *)buildWithData:(NSArray*)data;
@end
