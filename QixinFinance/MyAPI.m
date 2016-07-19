 //
//  MyAPI.m
//  ERVICE
//
//  Created by apple on 3/25/16.
//  Copyright © 2016 hbjApple. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFURLResponseSerialization.h>
#import "Marco.h"
#import "MyAPI.h"
#import "Config.h"
#define BaseUrl @"http://60.173.235.34:9090/qixin/app"
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
#import "UserInfoModel.h"
#import "InfoCateModel.h"
#import "MyLoanModel.h"
#import "HomePictureModel.h"

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

- (void)LoginWithNumber:(NSString *)phoneNumber password:(NSString *)password result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"phone":phoneNumber,
                                  @"userpwd":password
                                  };
    [self.manager POST:@"nos_login" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *state = responseObject[@"status"];
        NSString *information = responseObject[@"info"];
        if ([state isEqualToString:@"1"]) {
            NSDictionary *data = responseObject[@"data"];
          UserInfoModel *userinfo = [[UserInfoModel alloc] buildWithDatas:data];
       
           //保存个人信息至本地
            [[Config Instance] saveUserid:userinfo.uid userName:userinfo.username userPhoneNum:userinfo.phoneNum token:userinfo.token icon:userinfo.iconUrl];
            result(YES,information);
            
        }else{
            result(NO,information);
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);

    }];
}

-  (void)modifyPwdWithOldPassword:(NSString *)oldpassword mpassword:(NSString*)mpassword result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
    NSString * token = [[Config Instance] getToken];
    
    NSDictionary * parameter = @{@"token":token,@"oldpasswd":oldpassword,@"passwd":mpassword};
    [self.manager POST:@"qx_modipwd" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if ([status isEqualToString:@"1"]) {
        
            result(YES,info);
        }else{
            result(NO,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)RegistWithyzm:(NSString *)yzm password:(NSString *)password phoneNumber:(NSString *)phoneNumber result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"yzm":yzm,@"userpwd":password,@"phone":phoneNumber};
    [self.manager POST:@"nos_reg" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * state = responseObject[@"status"];
        NSString * information = responseObject[@"info"];
        if([state isEqualToString:@"1"]){
           
            result(YES,information);
        }else if([state isEqualToString:@"0"]){
           
            result(NO,information);
        }else{
            result(NO,information);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}

- (void)sendZhaoYZMWithPhoneNumber:(NSString *)phoneNumber result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"phone":phoneNumber};
    [self.manager POST:@"nos_sendzhyzm" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * state = responseObject[@"status"];
        NSString * information = responseObject[@"info"];
        if ([state isEqualToString:@"1"]) {
            result(YES,information);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
}

- (void)FindBackPasswordWithYZM:(NSString *)YZM phoneNumber:(NSString *)phoneNumber NewPassWord:(NSString *)newPassWord RePassWord:(NSString *)RePassWord Result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"yzm":YZM,@"phone":phoneNumber,@"passwd":newPassWord,@"repasswd":RePassWord};
    [self.manager POST:@"nos_qx_getpwd" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * state = responseObject[@"status"];
        NSString * info = responseObject[@"info"];
        if ([state isEqualToString:@"1"]) {
            result(YES,info);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)sendPhoneYZMWithphoneNumber:(NSString *)phoneNumber result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"phone":phoneNumber};
    [self.manager POST:@"nos_sendyzm" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * state = responseObject[@"status"];
        NSString * information = responseObject[@"info"];
        if ([state isEqualToString:@"1"]) {
            result(YES,information);
        }else{
            result(NO,information);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
    
}

- (void)uploadImage:(NSData *)imageData result:(StateBlock)result errorResult:(ErrorBlock)errorResult
{
   NSString * token = [[Config Instance] getToken];
    NSDictionary * parameter = @{@"token":token,@"image":imageData};
    [self.manager POST:@"nos_userimage" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            NSDictionary * data = responseObject[@"data"];
            NSString * imageUrl = data[@"imgthumb"];
            result(YES,imageUrl);
        }else {
           
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        errorResult(error);
    }];
}


- (void)getHomepageBannerWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    [self.manager POST:@"nos_qx_indexbanner" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            NSArray * data = responseObject[@"data"][@"adver_ban"];
           
                NSMutableArray * adArray = [[adverModel alloc] buildData:data];
            
            result(YES,@"SUCCESS",@[adArray]);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)getHomePagePictureWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
[self.manager POST:@"nos_qx_adimagef" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSString * status = responseObject[@"status"];
    if ([status isEqualToString:@"1"]) {
        NSArray * adImageArray = responseObject[@"data"][@"adimage"];
        
        NSMutableArray * HomePictureArray = [[HomePictureModel alloc] buildWithData:adImageArray];
        
        result(YES,@"SUCCESS",@[HomePictureArray]);
    }
} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    
}];
    
}

- (void)getHomePageCardPictureWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
[self.manager POST:@"nos_qx_adimages" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSString * status = responseObject[@"status"];
    if ([status isEqualToString:@"1"]) {
        NSArray * cardArray = responseObject[@"data"][@"adimage"];
        
        NSMutableArray * homecardArray = [[HomePictureModel alloc] buildWithData:cardArray];
        
        result(YES,@"SUCCESS",@[homecardArray]);
    }
} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    
}];
    
}

- (void)getInfoPageBannerWithResult:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    [self.manager POST:@"nos_qx_newsbanner" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            NSArray * data = responseObject[@"data"][@"news_ban"];
            NSMutableArray * adArray = [[adverModel alloc] buildData:data];
            result(YES,@"SUCCESS",@[adArray]);
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


//筛选
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

//理财精选
- (void)requestSelectLoanListWithPage:(NSString *)page Result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameters = @{@"page":page};
    [self.manager POST:@"nos_qx_financelist" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * data = responseObject[@"data"];
        NSArray * selectproductArray = data[@"financeinfo"];
        NSMutableArray * selectData = [[gfselectModel alloc] buildWithData:selectproductArray];
        result(YES,@"SUCCESS",@[selectData]);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)requestNewsListWithPage:(NSString *)page cateid:(NSString *)cateid Result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    NSDictionary * parameter = @{@"page":page};
    NSString * URL = [NSString stringWithFormat:@"nos_qx_articlelist/%@",cateid];
    [self.manager POST:URL parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * data = responseObject[@"data"];
        NSArray * newsArray = data[@"articlelist"];
        NSMutableArray * newsData = [[InfoCateModel alloc] buildWithData:newsArray];
        result(YES,@"SUCCESS",@[newsData]);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

//推荐贷款
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

//身份
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
    
    if([sort isKindOfClass:[NSNull class]]){
        sort = @"";
    } if ([jtype isKindOfClass:[NSNull class]]){
        jtype = @"";
    } if ([mtype isKindOfClass:[NSNull class]]){
        mtype = @"";
    }if ([rtype isKindOfClass:[NSNull class]]) {
        rtype = @"";
    }if([month isKindOfClass:[NSNull class]]){
        month = @"";
    }if ([money isKindOfClass:[NSNull class]]) {
        money = @"";
    }if ([page isKindOfClass:[NSNull class]]) {
        page = @"";
    }
    
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
        
        result(YES,@"SUCCESS",@[moreloanInfoArray]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)getMyLoanListWithPage:(NSString *)page Result:(ArrayBlock)result errorResult:(ErrorBlock)errorResult
{
    NSString * token = [[Config Instance] getToken];
    NSDictionary * parameter = @{@"token":token,@"page":page};
    [self.manager POST:@"qx_myborrow" parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * status = responseObject[@"status"];
        NSString *info = responseObject[@"info"];
        if ([status isEqualToString:@"-1"]) {
                      return ;
        }
        
        NSDictionary * data = responseObject[@"data"];
        if( data == [NSNull null]) {
      
            result(NO,info,nil);
            
            
        }else{
            NSArray * myloanArray =data[@"borrowinfo"];
            NSMutableArray * MyLoanArray = [[MyLoanModel alloc] buildWithData:myloanArray];
            result(YES,@"SUCCESS",@[MyLoanArray,status]);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
}

@end
