//
//  moneyModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moneyModel : NSObject
@property(nonatomic,copy)NSString * money;
@property(nonatomic,copy)NSString * value;
- (id)initWithmoney:(NSString*)money value:(NSString*)value;
- (NSMutableArray*)buildWithData:(NSArray*)data;
@end
