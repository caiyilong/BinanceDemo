//
//  ChildMarketViewController.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "ChildMarketViewController.h"
#import "../Views/MarketTableViewCell.h"
#import "../Tools/UITableView+refresh.h"
@interface ChildMarketViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

#define cellID @"marketCellID"
@implementation ChildMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    MJRefreshNormalHeader *heard = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.marketVC requstMarketDataWithCachIgnore:NO andFinishHanle:^{
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    self.tableView.mj_header = heard;
 
}
- (void)zj_viewDidLoadForIndex:(NSInteger)index {
   [self.view addSubview:self.tableView];
    
}

-(void)setMarketModels:(NSArray<MarketModel *> *)marketModels{
    _marketModels = marketModels;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.marketModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    cell.marketModel = [self.marketModels objectAtIndex:indexPath.row];
    return cell;
}
//0x7fae4e8bc200
//0x7fae4e8bf000
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-125) style:UITableViewStylePlain];
    
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 90.f;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
        [_tableView registerNib:[UINib nibWithNibName:@"MarketTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}



@end
















