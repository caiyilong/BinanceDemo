//
//  ChildMarketViewController.h
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "BaseViewController.h"
#import "../Tools/ZJScrollPageView/ZJScrollPageView.h"
#import "../Models/MarketModel.h"
#import "MarketViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChildMarketViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray<MarketModel *> * marketModels;
@property (nonatomic, strong) MarketViewController * marketVC;

@end

NS_ASSUME_NONNULL_END
