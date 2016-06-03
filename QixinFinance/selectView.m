//
//  selectView.m
//  select
//
//  Created by GBH-MAC on 16/2/4.
//  Copyright © 2016年 GBH-MAC. All rights reserved.
//

#import "selectView.h"
#import "MyAPI.h"
#import "selectViewTableViewCell.h"
#import "typelistModel.h"
#import "selectheaderView.h"
@interface selectView ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *indexAry;
    NSArray * dataSource;
}
@property(nonatomic,copy)NSArray * arr;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)selectheaderView *headerView;
@end

@implementation selectView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
             
        [[MyAPI sharedAPI] requestMoreLoanListWithResult:^(BOOL success, NSString *msg, NSArray *arrays) {
        
            dataSource = @[[NSArray arrayWithObjects:@{@"num":arrays[2]}, nil],[NSArray arrayWithObjects:@{@"num":arrays[3]}, nil],[NSArray arrayWithObjects:@{@"num":arrays[1]}, nil],[NSArray arrayWithObjects:@{@"num":arrays[4]}, nil]];
             indexAry = [NSArray arrayWithObjects:@{@"num":arrays[5]}, nil];
            [self setTableView];
            [self.tableView reloadData];
        } errorResult:^(NSError *enginerError) {
            
        }];
    
        
     
    }
    return self;
}

-(void)setTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [btn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"allloadfinish"] forState:UIControlStateNormal];
    _tableView.tableFooterView = btn;
    [self addSubview:_tableView];
    
}

- (void)finish
{
     self.hidden = YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
//    selectViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    if (!cell){
//         //NSLog(@"%ld",indexPath.section);
//        cell.i = 2;
//     //   NSLog(@"\\\\\\\\%lu\n",cell.i);
//        cell = [[selectViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        
//        
//    }
    selectViewTableViewCell * cell = [[selectViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellName"];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.array = dataSource[indexPath.section];
        [cell setCollectionView];
    
       return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0||indexPath.section==1) {
        return 95;
    }
    else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[selectheaderView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    _headerView.nameLabel.text = [NSString stringWithFormat:@"%@",[[[indexAry objectAtIndex:0]objectForKey:@"num"]objectAtIndex:section]];
    return _headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
  
    return 1.0;
    
    }
@end
