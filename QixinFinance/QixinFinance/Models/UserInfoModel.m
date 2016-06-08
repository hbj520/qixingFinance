//
//  UserInfoModel.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
- (id)initWithParams:(NSString *)userName phone:(NSString *)phone userId:(NSString *)uid token:(NSString *)token iconUrl:(NSString *)iconUrl
{
    UserInfoModel * userInfo = [[UserInfoModel alloc] init];
    userInfo.username = userName;
    userInfo.phoneNum = phone;
    userInfo.uid = uid;
    userInfo.token = token;
    userInfo.iconUrl = iconUrl;
    return userInfo;
}

- (UserInfoModel *)buildWithDatas:(NSDictionary *)datas
{
    NSString * name = [datas objectForKey:@"username"];
    NSString * phone = [datas objectForKey:@"phone"];
    NSString * userid = [datas objectForKey:@"uid"];
    NSString * token = [datas objectForKey:@"token"];
    NSString * iconUrl = [datas objectForKey:@"imgthumb"];
    UserInfoModel * userInfo = [[UserInfoModel alloc] initWithParams:name phone:phone userId:userid token:token iconUrl:iconUrl];
    return userInfo;
}
@end
