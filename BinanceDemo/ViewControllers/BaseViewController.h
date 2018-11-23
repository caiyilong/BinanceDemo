//
//  BaseViewController.h
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
///上拉刷新展示view
@property (nonatomic,strong) UIView *topRefreshView;

- (void)startTopRefreshImageAnimation;
- (void)stopTopRefreshImageAnimation;

@end

NS_ASSUME_NONNULL_END
