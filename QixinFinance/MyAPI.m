 //
//  MyAPI.m
//  ERVICE
//
//  Created by apple on 3/25/16.
//  Copyright © 2016 hbjApple. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFURLResponseSerialization.h>
#import "MyAPI.h"
#define BaseUrl @"http://60.173.235.34:9999/qixin/app"
//tools

//models
#import "adverModel.h"
#import "gfselectModel.h"
#import "loaninfoModel.h"
#import "sortModel.h"
@interface MyAPI()
@property NSString *mBaseUrl;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end
@implementation MyAPI
- (id)init{
    self = [super init];
    if (self) {

        self.manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BaseUrl]] ;
        self.manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        [self.manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-access-id"];
        [self.manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-signature"];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return self;
}
+ (MyAPI *)sharedAPI{
    static MyAPI *sharedAPIInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAPIInstance = [[self alloc] init];
    });
    return sharedAPIInstance;
}
- (void)cancelAllOperation{
    [self.manager.operationQueue cancelAllOperations];
}

- (void)getHomepageDataWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    [self.manager POST:@"nos_qx_index" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"-1"]) {//超时处理
            result(NO,@"登录超时",nil);
        }
        if ([status isEqualToString:@"1"]) {
            NSDictionary *data = responseObject[@"data"];
            NSDictionary * adDict = data[@"adver_ban"];
            NSArray * selectArray = data[@"gfselect"];
            NSArray * loanArray = data[@"loaninfo"];
            //首页滚动视图数据赋值
            NSMutableArray * adverData = [[adverModel alloc] buildData:adDict];
            NSMutableArray * selectData = [[gfselectModel alloc] buildWithData:selectArray];
            NSMutableArray * loanData = [[loaninfoModel alloc] buildWithData:loanArray];
            result(YES,@"获取成功",@[adverData,selectData,loanData]);
        }else{
            result(NO,@"获取失败",nil);
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)requestMoreLoanListWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    [self.manager POST:@"nos_qx_select" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * data = responseObject[@"data"];
        NSArray * sortArray = data[@"sort"];
        NSMutableArray * sortData = [[sortModel alloc] buildWithData:sortArray];
        
        result(YES,@"12323",@[sortData,@""]);
       
       
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)getMoreLoanWithSort:(NSString*)sort jtype:(NSString*)jtype mtype:(NSString*)mtype rtype:(NSString*)rtype btype:(NSString*)btype month:(NSString*)month money:(NSString*)money
{
    NSDictionary * parameters = @{
                                  @"sort":sort,
                                  @"jtype":jtype,
                                  @"mtype":mtype,
                                  @"rtype":rtype,
                                  @"btype":btype,
                                  @"month":month,
                                  @"money":money
                                  };
    [self.manager POST:@"nos_qx_loanlist" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

@end
