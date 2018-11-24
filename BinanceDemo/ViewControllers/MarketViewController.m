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



@interface MarketViewController ()<ZJScrollPageViewDelegate,UISearchBarDelegate>

@property (nonatomic, copy)  NSDictionary  *selectedModels;
@property (nonatomic, strong) NSSet * titleSet;
@property (nonatomic, strong) ZJScrollPageView * pageView;
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) ChildMarketViewController * currentVC;

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requstMarketDataWithCachIgnore:YES andFinishHanle:^{}];
    [self.view addSubview:self.pageView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#333333"]] forBarMetrics:UIBarMetricsDefault ];
    [self.navigationController.navigationBar addSubview:self.searchBar];

}

-(void)setTitleSet:(NSSet *)titleSet{
    //当交易对有变化时  刷新segment
    if (_titleSet.count > 0 && _titleSet.count!=titleSet.count) {
         [self.pageView reloadWithNewTitles:titleSet.allObjects];
    }
     _titleSet = titleSet;
}

-(void)setSelectedModels:(NSDictionary *)selectedModels{
    _selectedModels = selectedModels;
    [self selectDataForSearch:self.searchBar.text];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"------serchText:%@",searchText);
    [self selectDataForSearch:searchText];
}

-(void)selectDataForSearch:(NSString *)searchText{
    
    if (searchText.length==0) {
         self.currentVC.marketModels = [self.selectedModels objectForKey: [self.titleSet.allObjects objectAtIndex:self.index]];
        return;
    }
    NSArray<MarketModel *> *models = [self.selectedModels objectForKey: [self.titleSet.allObjects objectAtIndex:self.index]];
    NSMutableArray< MarketModel *> *searchArr = [NSMutableArray array];
    
    for (MarketModel *model in models) {
        if ([model.symbol containsString:[searchText uppercaseString]]) {
            [searchArr addObject:model];
        }
    }
    
     self.currentVC.marketModels = searchArr;
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
    self.index = index;
    self.searchBar.text = @"";
    [self.searchBar endEditing:YES];
    [self selectDataForSearch:@""];
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
            if (finishiHanle) {
                finishiHanle();
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (finishiHanle) {
            finishiHanle();
        }
        
    }];
}

#pragma mark ----------  lazy load  ---------

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth-40, 40)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索交易对";
    }
    return _searchBar;
}

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
