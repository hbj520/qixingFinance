//
//  DetailViewController.h
//  QixinFinance
//
//  Created by youyou on 16/5/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

