//
//  MarketModel.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "MarketModel.h"

@interface MarketModel()

@end

@implementation MarketModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.quoteAsset = [dic stringObjectForKey:@"quoteAsset"];
        self.baseAsset = [dic stringObjectForKey:@"baseAsset"];
        self.symbol = [dic stringObjectForKey:@"symbol"];
        self.baseAsset = [dic stringObjectForKey:@"baseAssetName"];
        self.volume = [dic stringObjectForKey:@"volume"];
        self.status = [dic stringObjectForKey:@"status"];
        self.open = [dic stringObjectForKey:@"open"];
        self.close = [dic stringObjectForKey:@"close"];
        self.active = [dic boolObjectForKey:@"active"];
    }
    return self;
}

@end
