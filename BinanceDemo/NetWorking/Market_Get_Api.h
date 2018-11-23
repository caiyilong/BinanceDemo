//
//  Market_Get_Api.h
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface Market_Get_Api : BaseRequest

-(NSArray *)marketModels;
-(NSSet *)titleSet;
-(NSDictionary *)selectedModels;
@end

NS_ASSUME_NONNULL_END
