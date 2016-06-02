//
//  ZHlookHouseSmarFourCell.m
//  Zoharo
//
//  Created by GBH-MAC on 16/1/13.
//  Copyright © 2016年 Coelong. All rights reserved.
//

#import "ZHlookHouseSmarFourCell.h"
#define width [UIScreen mainScreen].bounds.size.width
@implementation ZHlookHouseSmarFourCell
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}
-(void)setupView{
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.numberOfLines = 0;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.userInteractionEnabled = YES;
    _nameLabel.frame = CGRectMake(0, 0, (width - 60)/4, 30);
    if (self.selected) {
       
    }
    [self.contentView addSubview:_nameLabel];
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0f;
    [self setTintColor:[UIColor grayColor]];
//    self.layer.borderWidth = .5;
//    self.layer.borderColor = [UIColor redColor].CGColor;
    _nameLabel.textColor = [UIColor blackColor];
}
-(void)setName:(NSString *)name{
    _nameLabel.text = name;
     _nameLabel.backgroundColor = [UIColor colorWithRed:227/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    // _nameLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        //选中时
        _nameLabel.backgroundColor = [UIColor orangeColor];
    }else{
        //非选中
        _nameLabel.backgroundColor = [UIColor colorWithRed:227/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
