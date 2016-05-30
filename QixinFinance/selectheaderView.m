//
//  selectheaderView.m
//  select
//
//  Created by GBH-MAC on 16/2/4.
//  Copyright © 2016年 GBH-MAC. All rights reserved.
//

#import "selectheaderView.h"

@implementation selectheaderView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
       _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.numberOfLines = 0;
//        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.frame = CGRectMake(10, 5, self.frame.size.width - 20, 30);
        [self addSubview:_nameLabel];
    }
    return self;
}

@end
