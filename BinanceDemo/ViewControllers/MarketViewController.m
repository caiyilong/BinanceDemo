//
//  MarketViewController.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "MarketViewController.h"
#import "../NetWorking/Market_Get_Api.h"
#import "../Tools/ZJScrollPageView/ZJScrollPageView.h"
#import "ChildMarketViewController.h"
#import "../Models/MarketModel.h"



@interface MarketViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, copy)  NSDictionary  *selectedModels;
@property (nonatomic, strong) NSSet * titleSet;
@property (nonatomic, strong) ZJScrollPageView * pageView;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) ChildMarketViewController * currentVC;

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requstMarketDataWithCachIgnore:YES andFinishHanle:^{
        
    }];
    [self.view addSubview:self.pageView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#333333"]] forBarMetrics:UIBarMetricsDefault ];
    self.navigationController.navigationItem.title = @"Market";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}


-(void)setTitleSet:(NSSet *)titleSet{
    _titleSet = titleSet;
    [self.pageView reloadWithNewTitles:titleSet.allObjects];
}

-(void)setSelectedModels:(NSDictionary *)selectedModels{
    _selectedModels = selectedModels;
    self.currentVC.marketModels = [selectedModels objectForKey: [self.titleSet.allObjects objectAtIndex:self.index]];
}

#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titleSet.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    ChildMarketViewController *childVc = (ChildMarketViewController *)reuseViewController;
    if (!childVc) {
        childVc = [[ChildMarketViewController alloc] init];
        NSString *key = [[self.titleSet allObjects] objectAtIndex:index];
        childVc.marketModels= [self.selectedModels objectForKey:key];
        childVc.marketVC = self;
    }
    self.currentVC = childVc;
    NSLog(@"%ld-----%@",(long)index, childVc);
    
    return childVc;
}


-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}



#pragma mark ---------- requstData -------------

-(void)requstMarketDataWithCachIgnore:(BOOL) isFromCache andFinishHanle:(void(^)(void)) finishiHanle {
    Market_Get_Api *marketApi = [[Market_Get_Api alloc] init];
    if (isFromCache) {
        if ([marketApi loadCacheWithError:nil]) {
            
            if ([marketApi titleSet].count >0) {
               
                self.titleSet = [marketApi titleSet];
                self.selectedModels = [marketApi selectedModels];
            }
            
        }
    }
    
    marketApi.ignoreCache = YES;
    [marketApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"------------->获取网络数据成功");
        if (request.responseObject) {
            self.selectedModels = [marketApi selectedModels];
            self.titleSet = [marketApi titleSet];
            finishiHanle();
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        finishiHanle();
        
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
        _pageView = [[ZJScrollPageView alloc] initWithFrame:self.view.frame segmentStyle:style titles:self.titleSet.allObjects parentViewController:self delegate:self];
        _pageView.segmentView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    }
    
    return _pageView;
}



@end
