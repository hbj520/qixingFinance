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
#import "moreloaninfoModel.h"
#import "sortModel.h"
#import "typelistModel.h"
#import "moneyModel.h"
#import "monthModel.h"
#import "JobInfoModel.h"

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

- (void)getHomepageBannerWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    [self.manager POST:@"nos_qx_indexbanner" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            NSArray * data = responseObject[@"data"][@"adver_ban"];
           
                NSMutableArray * adArray = [[adverModel alloc] buildData:data];
            
            result(YES,@"SUCCESS",adArray);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
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
         //   NSDictionary * adDict = data[@"adver_ban"];
            NSArray * selectArray = data[@"gfselect"];
            NSArray * loanArray = data[@"loaninfo"];
            //首页滚动视图数据赋值
           // NSMutableArray * adverData = [[adverModel alloc] buildData:adDict];
            NSMutableArray * selectData = [[gfselectModel alloc] buildWithData:selectArray];
            NSMutableArray * loanData = [[loaninfoModel alloc] buildWithData:loanArray];
            result(YES,@"获取成功",@[selectData,loanData]);
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
       
        NSArray *btypelistArray = data[@"btype"][@"list"];
        NSMutableArray * blistArray = [[typelistModel alloc] buildWithData:btypelistArray];
        
        NSArray *jtypeArray = data[@"jtype"][@"list"];
        NSMutableArray * jlistArray = [[typelistModel alloc] buildWithData:jtypeArray];
        
        NSArray * mtypeArray = data[@"mtype"][@"list"];
        NSMutableArray *mlistArray = [[typelistModel alloc] buildWithData:mtypeArray];
        
        NSArray * rtypeArray = data[@"rtype"][@"list"];
        NSMutableArray * rlistArray = [[typelistModel alloc] buildWithData:rtypeArray];
        
        NSString *bname = data[@"btype"][@"name"];
        NSString * jname = data[@"jtype"][@"name"];
        NSString * mname =  data[@"mtype"][@"name"];
         NSString * rname =  data[@"rtype"][@"name"];
        
        NSArray * moneyArray = data[@"money"];
        NSMutableArray * moneyArray1 = [[moneyModel alloc] buildWithData:moneyArray];
        
        NSArray * monthArray = data[@"month"];
        NSMutableArray * monthArray1 = [[monthModel alloc] buildWithData:monthArray];
    
        NSMutableArray * nameArray = @[jname,mname,bname,rname];
        result(YES,@"SUCCESS",@[sortData,blistArray,jlistArray,mlistArray,rlistArray,nameArray,moneyArray1,monthArray1]);
       
       
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)getrecommandIoaninfoWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
[self.manager POST:@"nos_qx_loanrec" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSDictionary * data = responseObject[@"data"];
    NSArray * loanInfoArray = data[@"loaninfo"];
    NSMutableArray * moreloanInfoArray = [[moreloaninfoModel alloc] buildWithData:loanInfoArray];
    result(YES,@"SUCCESS",moreloanInfoArray);
} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    
}];
}

- (void)getJobInfoWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    [self.manager POST:@"nos_qx_jobtype" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * data = responseObject[@"data"];
        NSDictionary * workdict = data[@"1"];
        JobInfoModel * model1 = [[JobInfoModel alloc] buildWithData:workdict];
        
        NSDictionary * qiyedict =  data[@"2"];
        JobInfoModel * model2 = [[JobInfoModel alloc] buildWithData:qiyedict];
        
        NSDictionary *  freedict = data[@"3"];
        JobInfoModel * model3 = [[JobInfoModel alloc] buildWithData:freedict];
        
        NSDictionary * studict = data[@"4"];
        JobInfoModel * model4 = [[JobInfoModel alloc] buildWithData:studict];
        
        NSDictionary *  dict = data[@"5"];
        JobInfoModel * model5 = [[JobInfoModel alloc] buildWithData:dict];
        
        NSArray * jobArray = @[model1,model2,model3,model4,model5];
        result(YES,@"SUCCESS",jobArray);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)getMoreLoanWithSort:(NSString*)sort jtype:(NSString*)jtype mtype:(NSString*)mtype rtype:(NSString*)rtype btype:(NSString*)btype month:(NSString*)month money:(NSString*)money page:(NSString *)page  Result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{
                                  @"sort":sort,
                                  @"jtype":jtype,
                                  @"mtype":mtype,
                                  @"rtype":rtype,
                                  @"btype":btype,
                                  @"month":month,
                                  @"money":money,
                                  @"page":page
                                  };
    [self.manager POST:@"nos_qx_loanlist" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * data = responseObject[@"data"];
        NSArray * loanInfoArray = data[@"loaninfo"];
        NSMutableArray * moreloanInfoArray = [[moreloaninfoModel alloc] buildWithData:loanInfoArray];
        result(YES,@"SUCCESS",moreloanInfoArray);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

@end
