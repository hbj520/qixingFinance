//
//  UserInfoModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property(nonatomic,copy)NSString * username;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * phoneNum;
@property(nonatomic,copy)NSString * token;
@property(nonatomic,copy)NSString * iconUrl;

- (id)initWithParams:(NSString*)userName phone:(NSString*)phone userId:(NSString*)uid token:(NSString*)token iconUrl:(NSString*)iconUrl;

- (UserInfoModel*)buildWithDatas:(NSDictionary*)datas;

@end
