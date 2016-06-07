//
//  Config.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/3.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject
+ (Config*)Instance;
+ (id)allocWithZone:(NSZone *)zone;

//保存用户userid 用户name 用户phone token
- (void)saveUserid:(NSString *)userid
          userName:(NSString *)username
      userPhoneNum:(NSString *)PhoneNum
             token:(NSString *)token
              icon:(NSString *)icon;
//保存密码
- (void)saveUserPassword:(NSString *)password;
//保存头像url
- (void)saveIcon:(NSString *)icon;
//获取本地保存的用户userid 用户name 用户phone token,密码
- (NSString *)getUserid;
- (NSString *)getUserName;
- (NSString *)getUserPhoneNum;
- (NSString *)getToken;
- (NSString *)getUserIcon;
- (NSString *)getPassword;



@end
