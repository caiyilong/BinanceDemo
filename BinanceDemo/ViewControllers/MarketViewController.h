//
//  MarketViewController.h
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "BaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface MarketViewController : BaseViewController
@property (nonatomic, assign) NSInteger  index;
-(void)requstMarketDataWithCachIgnore:(BOOL) isFromCache andFinishHanle:(void(^)(void)) finishiHanle;
@end

NS_ASSUME_NONNULL_END
