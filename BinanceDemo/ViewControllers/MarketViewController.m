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



@interface MarketViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, copy) NSArray * MarketModels;
@property (nonatomic, strong) ZJScrollPageView * pageView;

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requstMarketData];
    [self.view addSubview:self.pageView];
    
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
            self.MarketModels = [marketApi marketModels];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

-(void)setMarketModels:(NSArray *)MarketModels{
    _MarketModels = MarketModels;
    
    
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
        
      //  style.normalTitleColor = [UIColor ];
      //  style.selectedTitleColor = SKIN_COLOR_STYLE(Main_Black);
       // style.titleFont = SKIN_FONT_STYLE_FAMILY(FontSize_14, SFProText_Medium);
        style.scrollLineHeight = 2.0;
       // style.scrollLineColor = SKIN_COLOR_STYLE(Main_Purple);
        style.titleBigScale = 1.0;
        _pageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88) segmentStyle:style titles:@[@"BTC",@"BNB",@"ETH",@"USDT"] parentViewController:self delegate:self];
    }
    return _pageView;
}



@end
