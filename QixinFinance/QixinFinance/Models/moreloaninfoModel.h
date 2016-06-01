//
//  moreloaninfoModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moreloaninfoModel : NSObject
@property(nonatomic,copy)NSString * infoId;
@property(nonatomic,copy)NSString * mrate;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSNumber *number;
@property(nonatomic,copy)NSString * thumbimg;

- (id)initWithinfoId:(NSString*)infoId mrate:(NSString*)mrate name:(NSString*)name number:(NSNumber*)number thumbimg:(NSString*)thumbimg;
- (NSMutableArray*)buildWithData:(NSArray*)data;
@end
