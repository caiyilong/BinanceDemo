//
//  MarketModel.h
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketModel : NSObject

@property (nonatomic, copy) NSString * quoteAsset;
@property (nonatomic, copy) NSString * baseAsset;
@property (nonatomic, copy) NSString * symbol;
@property (nonatomic, copy) NSString * baseAssetName;
@property (nonatomic, copy) NSString * volume;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, assign) BOOL  active;
@property (nonatomic, copy) NSString * open;
@property (nonatomic, copy) NSString * close;


-(instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
