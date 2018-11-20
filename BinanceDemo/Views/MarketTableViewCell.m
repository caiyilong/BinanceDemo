//
//  MarketTableViewCell.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "MarketTableViewCell.h"

@interface MarketTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *childCoinLbl;
@property (weak, nonatomic) IBOutlet UILabel *matherCoinLbl;
@property (weak, nonatomic) IBOutlet UILabel *volLbl;
@property (weak, nonatomic) IBOutlet UILabel *btcPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *usdPriceLbl;

@end

@implementation MarketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMarketModel:(MarketModel *)marketModel{
    _marketModel = marketModel;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
