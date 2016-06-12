//
//  HomeDetailViewController.h
//  QixinFinance
//
//  Created by 张哲 on 16/5/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFURLResponseSerialization.h>

@interface HomeDetailViewController : BaseViewController

@property(nonatomic,copy)NSString * uid;//模型的id

@property(nonatomic,copy)NSString * url; //链接网址

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end
