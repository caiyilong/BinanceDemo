//
//  MarketViewController.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "MarketViewController.h"
#import "../NetWorking/Market_Get_Api.h"
#import <ZJScrollPageView/ZJScrollPageView.h>
#import "ChildMarketViewController.h"
#import "../Models/MarketModel.h"



@interface MarketViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, copy) NSArray<MarketModel *> * marketModels;
@property (nonatomic, strong) ZJScrollPageView * pageView;

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requstMarketData];
    [self.view addSubview:self.pageView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#333333"]] forBarMetrics:UIBarMetricsDefault ];
    self.navigationController.navigationItem.title = @"Market";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return 4;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    ChildMarketViewController *childVc = (ChildMarketViewController *)reuseViewController;
    
    if (!childVc) {
        childVc = [[ChildMarketViewController alloc] init];
        
       
    }
    
    NSLog(@"%ld-----%@",(long)index, childVc);
  
    
    return childVc;
}


#pragma mark ---------- requstData -------------

-(void)requstMarketData{
    Market_Get_Api *marketApi = [[Market_Get_Api alloc] init];
    [marketApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (request.responseObject) {
            self.marketModels = [marketApi marketModels];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

-(void)setMarketModels:(NSArray<MarketModel *> *)marketModels{
    _marketModels = marketModels;
    [self selectData:marketModels];

}
-(void)selectData:(NSArray<MarketModel *> *)arr{
    //筛选母币
    NSMutableArray<NSDictionary *> *mainMulArr = [NSMutableArray array];
  
    NSMutableArray *nameArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(MarketModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [nameArr addObject:obj.quoteAsset];
       
    }];
     NSSet *mathorCoinSet = [NSSet setWithArray:nameArr.copy];
    //根据母币分类
    [mathorCoinSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableArray *itemArr = [NSMutableArray array];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:itemArr forKey:obj];
        [mainMulArr addObject:dic];
    }];
    
    [arr enumerateObjectsUsingBlock:^(MarketModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSDictionary *dic in mainMulArr) {
            if ([[dic allKeys].firstObject isEqualToString:obj.quoteAsset]) {
                NSMutableArray *arr = [dic objectForKey:obj.quoteAsset];
                [arr addObject:obj];
            }
        }
    }];
   
    
}



#pragma mark ----------  lazy load  ---------

-(ZJScrollPageView *)pageView{
    if (!_pageView) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showLine = YES;
        style.scrollTitle = NO;
        style.adjustCoverOrLineWidth = YES;
        // 颜色渐变
        style.gradualChangeTitleColor = YES;
        
        style.segmentHeight = 39.0;
        
        style.titleMargin = 29.0;
        
        style.normalTitleColor = [UIColor colorWithHexString:@"#ffffff"];
        style.selectedTitleColor = [UIColor colorWithHexString:@"#FFFF00"];
        style.scrollLineHeight = 2.0;
        style.scrollLineColor = [UIColor colorWithHexString:@"#FFFF00"];
        style.titleBigScale = 1.0;
        _pageView = [[ZJScrollPageView alloc] initWithFrame:self.view.frame segmentStyle:style titles:@[@"BTC",@"BNB",@"ETH",@"USDT"] parentViewController:self delegate:self];
        _pageView.segmentView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    }
    
    return _pageView;
}



@end
