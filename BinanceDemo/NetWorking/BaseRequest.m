//
//  BaseRequest.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    //添加请求头信息
    return @{@"Type_soure":@"iOS"};
}
/*
-(NSInteger)code{
    int code = [[self responseJSONObject] intObjectForKey:@"code"];
    return code;
}

-(NSString *)msg{
    return [[self responseJSONObject] stringObjectForKey:@"msg"];
}
*/
-(void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    @try{
        YTKRequestCompletionBlock successBlock = ^(__kindof YTKBaseRequest *request){
            
                if (success) {
                    success(request);
                }
                //处理一些全局错误码
              //  [[YTKNetworkAgent sharedAgent] cancelAllRequests];
            
        };
        YTKRequestCompletionBlock failBlock = ^(__kindof YTKBaseRequest *request){
            if (failure) {
                NSLog(@"=========== %@%@请求错误:%@ =======",self.baseUrl,self.requestUrl,request.error);
                failure(request);
            }
        };
        [super startWithCompletionBlockWithSuccess:successBlock failure:failBlock];
    }
    @catch(NSException *exception) {
        NSLog(@"exception:%@", exception);
    }
    @finally {
        
    }
}

@end
