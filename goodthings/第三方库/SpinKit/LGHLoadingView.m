//
//  LGHLoadingView.m
//  goodthings
//
//  Create by  on 15/10/16.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "LGHLoadingView.h"

@implementation LGHLoadingView
- (id)initWithFrame:(CGRect)frame loadingViewStyle:(RTSpinKitViewStyle)style AnimationViewcolor:(UIColor *)color  backGroundColor:(UIColor*)backGroundColor{
    
    if (self = [super initWithFrame:frame])
    {
     self.backgroundColor = backGroundColor;
    RTSpinKitView *spinKitView = [[RTSpinKitView alloc]initWithStyle:style color:color];
   
    spinKitView.frame = CGRectMake(0,0,40,30);
    spinKitView.center = CGPointMake(kScreenWidth/2.0+10, kScreenHeight/2.0-100);
    [self addSubview:spinKitView];
        
    }
    return self;
}
- (void)removeLoadingView{
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
