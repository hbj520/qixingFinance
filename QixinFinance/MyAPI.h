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
typedef void (^ArrayBlock) (BOOL success, NSString *msg, NSArray *arrays);
typedef void (^ErrorBlock) (NSError *enginerError);

@interface MyAPI : NSObject
+ (MyAPI *)sharedAPI;

//取消所有网路全部请求
- (void)cancelAllOperation;

/**
 *  获取首页信息
 *
 *  @return
 */

- (void)getHomepageDataWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;
/**
 *
 *筛选数据
 *  @param result
 *  @param errorResult 
 */
- (void)requestMoreLoanListWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

- (void)getIoaninfoWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;
/**
 *  筛选详情页面的webView回调
 */
/**
 *
 *
 *  @param sort  sort的id
 *  @param jtype jtype的id
 *  @param mtype mtype的id
 *  @param rtype rtype的id
 *  @param btype btype的id
 *  @param month month的id
 *  @param money money的id
 */
- (void)getMoreLoanWithSort:(NSString*)sort jtype:(NSString*)jtype mtype:(NSString*)mtype rtype:(NSString*)rtype btype:(NSString*)btype month:(NSString*)month money:(NSString*)money;
@end
