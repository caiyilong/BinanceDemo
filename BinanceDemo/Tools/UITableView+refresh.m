//
//  UITableView+refresh.m
//  BinanceDemo
//
//  Created by cai on 2018/11/21.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "UITableView+refresh.h"

static void *strKey = &strKey;
@implementation UITableView (refresh)

-(void)setCa_refreshControl:(UIRefreshControl *)ca_refreshControl{
     objc_setAssociatedObject(self, & strKey, ca_refreshControl, OBJC_ASSOCIATION_RETAIN);
}

-(UIRefreshControl *)ca_refreshControl{
    return objc_getAssociatedObject(self, & strKey);
}



@end
