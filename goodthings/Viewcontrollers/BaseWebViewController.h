//
//  BaseWebViewController.h
//  goodthings
//
//  Created by 李国怀 on 16/3/18.
//  Copyright © 2016年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)LGHLoadingView *loadingView;
@end
