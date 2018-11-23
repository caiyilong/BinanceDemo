//
//  UITableView+refresh.h
//  BinanceDemo
//
//  Created by cai on 2018/11/21.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (refresh)
@property (nonatomic, strong) UIRefreshControl * ca_refreshControl;
@end

NS_ASSUME_NONNULL_END
