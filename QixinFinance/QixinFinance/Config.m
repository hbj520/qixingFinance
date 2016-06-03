//
//  Config.m
//  QixinFinance
//
//  Created by 张哲 on 16/6/3.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "Config.h"

@implementation Config

static Config *instance = nil;
+ (Config *)Instance{
    @synchronized(self) {
        if (nil == instance) {
            [self new];
        }
    }
    return instance;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

@end
