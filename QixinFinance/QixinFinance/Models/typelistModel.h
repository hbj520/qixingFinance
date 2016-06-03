//
//  typelistModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/31.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface typelistModel : NSObject
@property(nonatomic,copy)NSString*dname;
@property(nonatomic,copy)NSString*listid;
@property(nonatomic,copy)NSString *fromname;
- (id)initWithdname:(NSString*)dname listid:(NSString*)listid fromname:(NSString*)fromname;
- (NSMutableArray *)buildWithData:(NSArray*)data;
@end
