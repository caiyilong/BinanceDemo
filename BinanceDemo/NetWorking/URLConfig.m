//
//  URLConfig.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "URLConfig.h"

#define PRODUCT_URL @"https://www.binance.com"

@implementation URLConfig


#define PRODUCT_ENVIRONMENT 0
NSString *WEB_URL;

#if PRODUCT_ENVIRONMENT == 0   //线上
NSString *WEB_URL = PRODUCT_URL;

#elif PRODUCT_ENVIRONMENT == 1 //预生产

#elif PRODUCT_ENVIRONMENT == 2 //测试环境

#elif PRODUCT_ENVIRONMENT == 3 //开发环境

#else

#endif



///行情
NSString *MAIKET_URL = @"/exchange/public/product";

@end
