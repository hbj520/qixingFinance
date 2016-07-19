//
//  HomePictureModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePictureModel : NSObject
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * imgthumb;
@property(nonatomic,copy)NSString * link;
@property(nonatomic,copy)NSString * title;

- (id)initWithUid:(NSString *)uid Imgthumb:(NSString *)imgthumb Link:(NSString*)link Title:(NSString*)title;

- (NSMutableArray*)buildWithData:(NSArray*)data;
@end
