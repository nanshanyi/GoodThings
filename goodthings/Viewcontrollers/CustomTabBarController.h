//
//  CustomTableViewController.h
//  everyDay
//
//  Create by  on 15/10/5.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarController : UITabBarController

@property (nonatomic)UIView *imageView;
//创建tabbar上使用的内容controllers
- (void)createContentViewControllers;

//自定义我们的一个tabBar
- (void)customTabBar;
@end
