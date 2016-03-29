//
//  BaseViewController.m
//  goodthings
//
//  Create by 】 on 15/10/14.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BaseViewController.h"
#import "SettingViewController.h"
#import "CustomTabBarController.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavbar];
     self.view.backgroundColor = [UIColor whiteColor];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    // Do any additional setup after loading the view.
}
- (void)customNavbar{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(11, 0, 11, 20)];
    [leftButton setImage:[UIImage imageNamed:@"iconfont-vynildarkgreen"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(musicPlayer) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(11,20, 11, 0)];
    [rightButton setImage:[UIImage imageNamed:@"iconfont-menugreen"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item2;
    
}
- (void)hiddenTabBar{
    CustomTabBarController *customTC = (CustomTabBarController*)self.tabBarController;
    [UIView animateWithDuration:0.3 animations:^{
        customTC.imageView.transform = CGAffineTransformTranslate(customTC.imageView.transform , 0, 50);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
//     self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidAppear:(BOOL)animated{
    
    CustomTabBarController *customTC = (CustomTabBarController*)self.tabBarController;
    [UIView animateWithDuration:0.2 animations:^{
        customTC.imageView.transform = CGAffineTransformIdentity;
    }];
}
- (void)musicPlayer{
    [self presentViewController:[MusicPlayerViewController shareInstance] animated:YES completion:nil];
}
- (void)setting{
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
