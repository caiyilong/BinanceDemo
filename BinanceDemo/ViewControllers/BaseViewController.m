//
//  BaseViewController.m
//  BinanceDemo
//
//  Created by cai on 2018/11/19.
//  Copyright © 2018 com.caiyilong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,weak)   UIImageView *topRefreshImage;
@property (nonatomic,assign) BOOL isTopRefreshImageAnimating;
@property (nonatomic,assign) CGFloat lastTopRefreshImageAngle;

@end

@implementation BaseViewController

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.isTopRefreshImageAnimating = NO;
        self.lastTopRefreshImageAngle = 0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

///下拉刷新展示view
- (UIView *)topRefreshView{
    if (!_topRefreshView) {
        _topRefreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _topRefreshView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *refreshImage = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-30)*0.5, 10, 30, 30)];
        refreshImage.image = [UIImage imageNamed:@"refresh_icon"];
        [_topRefreshView addSubview:refreshImage];
        
        self.topRefreshImage = refreshImage;
        
    }
    
    return _topRefreshView;
}

///Start Animation
- (void)beginTopRefreshImageAnimationWithAngle:(CGFloat)angles
{
    __block CGFloat angle = angles;
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI /180.0f));
    
    [UIView animateWithDuration:0.08 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.topRefreshImage.transform = endAngle;
        
    } completion:^(BOOL finished) {
        
        angle += 15;
        self.lastTopRefreshImageAngle = angle;
        
        if (self.isTopRefreshImageAnimating) {
            [self beginTopRefreshImageAnimationWithAngle:angle];
        }
        
    }];
}

- (void)startTopRefreshImageAnimation{
    
    self.isTopRefreshImageAnimating = YES;
    [self beginTopRefreshImageAnimationWithAngle:_lastTopRefreshImageAngle];
}

- (void)stopTopRefreshImageAnimation{
    self.isTopRefreshImageAnimating = NO;
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
