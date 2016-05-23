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
#define BaseUrl @"http://60.173.235.34:9999/svnupdate/app/"
//tools

//models



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


@end
