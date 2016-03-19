//
//  LGHLoadingView.h
//  goodthings
//
//  Create by  on 15/10/16.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTSpinKitView.h"
@interface LGHLoadingView : UIView
- (id)initWithFrame:(CGRect)frame loadingViewStyle:(RTSpinKitViewStyle)style AnimationViewcolor:(UIColor *)color  backGroundColor:(UIColor*)backGroundColor;
- (void)removeLoadingView;
@end
