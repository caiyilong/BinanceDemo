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



@end
