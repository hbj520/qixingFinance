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
 *  首页banner
 *
 *  @param result      banner模型数组
 *  @param errorResult 
 */
- (void)getHomepageBannerWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;
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

/**
 *  贷款详情列表页数据
 *
 *  @param result    详情数据模型数组
 *  @param errorResult 错误信息
 */

/**
 *  职业身份信息
 *
 *  @param result      身份信息模型数组
 *  @param errorResult 
 */
- (void)getJobInfoWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;

/**
 *  推荐贷款
 *
 *  @param result      推荐贷款模型
 *  @param errorResult 
 */
- (void)getrecommandIoaninfoWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult;
/**
 *  筛选详情页面
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
