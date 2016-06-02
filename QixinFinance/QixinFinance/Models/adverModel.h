//
//  adverModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adverModel : NSObject
@property(nonatomic,copy)NSString * adimageUrl;
@property(nonatomic,copy)NSString *adName;
@property(nonatomic,copy)NSString *adId;
@property(nonatomic,copy)NSString *link;
- (id)initWithLink:(NSString *)link imageurl:(NSString *)imageurl adName:(NSString*)adName adId:(NSString*)adId;
- (NSMutableArray *)buildData:(NSArray *)data;
@end
