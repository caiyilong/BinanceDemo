//
//  MarketTableViewCell.h
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Models/MarketModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarketTableViewCell : UITableViewCell
@property (nonatomic, strong) MarketModel * marketModel;
@end

NS_ASSUME_NONNULL_END
