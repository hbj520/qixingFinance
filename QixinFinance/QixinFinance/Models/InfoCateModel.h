//
//  InfoCateModel.h
//  QixinFinance
//
//  Created by 张哲 on 16/6/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoCateModel : NSObject
@property(nonatomic,copy)NSString * articleid;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * catename;
@property(nonatomic,copy)NSString * imgthumb;
@property(nonatomic,copy)NSString * ctime;
- (id)initWithParameter:(NSString *)articleid  title:(NSString *)title catename:(NSString*)catename imgthumb:(NSString *)imgthumb ctime:(NSString *)ctime;
- (NSMutableArray *)buildWithData:(NSArray *)data;
@end
