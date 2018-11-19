//
//  MarketViewController.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "MarketViewController.h"
#import "../NetWorking/Market_Get_Api.h"

@interface MarketViewController ()

@property (nonatomic, copy) NSArray * MarketModels;

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requstMarketData];
    
}

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



@end
