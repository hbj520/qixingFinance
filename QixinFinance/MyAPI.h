//
//  MyAPI.h
//  ERVICE
//
//  Created by apple on 3/25/16.
//  Copyright © 2016 hbjApple. All rights reserved.
// 下载类

#import <Foundation/Foundation.h>
typedef void (^VoidBlock) (void);
typedef void (^StateBlock) (BOOL sucess, NSString *msg);
typedef void (^ModelBlock) (BOOL success, NSString *msg, id object);
typedef void (^ArrayBlock) (BOOL success, NSString *msg, NSMutableArray *arrays);
typedef void (^ErrorBlock) (NSError *enginerError);

@interface MyAPI : NSObject
+ (MyAPI *)sharedAPI;

//取消所有网路全部请求
- (void)cancelAllOperation;


@end
