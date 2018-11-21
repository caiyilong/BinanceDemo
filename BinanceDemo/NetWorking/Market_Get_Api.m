//
//  Market_Get_Api.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "Market_Get_Api.h"
#import "../Models/MarketModel.h"


@implementation Market_Get_Api

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

-(NSString *)requestUrl{
    return MAIKET_URL;
}

-(NSInteger)cacheTimeInSeconds{
    //三小时缓存
    return 60*60*3;
}

-(NSArray *)marketModels{
    NSDictionary *dic = self.responseObject;
    if ([[dic allKeys] containsObject:@"data"]) {
        
        NSArray *dicArr = [dic objectForKey:@"data"];
        NSMutableArray *modelArr = [NSMutableArray array];
        for (NSDictionary *items in dicArr) {
            MarketModel *model = [[MarketModel alloc] initWithDic:items];
            [modelArr addObject:model];
        }
        return modelArr.copy;
    }
    return @[];
}

-( NSMutableArray<NSDictionary *> *)selectedModels{
    NSMutableArray<NSDictionary *> *mainMulArr = [self selectData:[self marketModels]];
    return mainMulArr;
}

-(NSSet *)titleSet{
    NSMutableArray *nameArr = [NSMutableArray array];
    [[self marketModels] enumerateObjectsUsingBlock:^(MarketModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [nameArr addObject:obj.quoteAsset];
        
    }];
    NSSet *mathorCoinSet = [NSSet setWithArray:nameArr.copy];
    return mathorCoinSet;
}

-( NSMutableArray<NSDictionary *> *)selectData:(NSArray<MarketModel *> *)arr{
    //筛选母币
    NSMutableArray<NSDictionary *> *mainMulArr = [NSMutableArray array];
    NSSet *mathorCoinSet = [self titleSet];
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
    return mainMulArr;
    
}



@end
