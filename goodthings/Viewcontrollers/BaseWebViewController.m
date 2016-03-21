//
//  BaseWebViewController.m
//  goodthings
//
//  Created by 李国怀 on 16/3/18.
//  Copyright © 2016年 LiGuohuai. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.alpha = 0.0;
    [self addWebView];
    [self creatNavgationBar];
    [self addLoadingView];
    // Do any additional setup after loading the view.
}
- (void)addWebView{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.delegate = self;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}
- (void)creatNavgationBar{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImageEdgeInsets:UIEdgeInsetsMake(11, 0, 11, 20)];
    [button setImage:[UIImage imageNamed:@"iconfont-chevronleftgreen"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton *rithtButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rithtButton.frame = CGRectMake(0, 0, 44, 44);
    [rithtButton setImageEdgeInsets:UIEdgeInsetsMake(11,20, 11, 0)];
    [rithtButton setImage:[UIImage imageNamed:@"iconfont-vynilGreen"] forState:UIControlStateNormal];
    [rithtButton addTarget:self action:@selector(musicPlayer) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rithtButton];
    
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(20, 20, 44, 44);
    [leftbutton setImageEdgeInsets:UIEdgeInsetsMake(11, 0, 11, 20)];
    [leftbutton setImage:[UIImage imageNamed:@"iconfont-chevronleftgreen"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftbutton];
    
    UIButton *rithtButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rithtButton1.frame = CGRectMake(kScreenWidth-44-20 ,20, 44, 44);
    [rithtButton1 setImageEdgeInsets:UIEdgeInsetsMake(11,20, 11, 0)];
    [rithtButton1 setImage:[UIImage imageNamed:@"iconfont-vynilGreen"] forState:UIControlStateNormal];
    [rithtButton1 addTarget:self action:@selector(musicPlayer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rithtButton1];
}
- (void)addLoadingView{
    
    self.loadingView = [[LGHLoadingView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) loadingViewStyle:RTSpinKitViewStyleWave AnimationViewcolor:kDarkGreenColor backGroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];
    
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)musicPlayer{
    [self presentViewController:[MusicPlayerViewController shareInstance] animated:YES completion:nil];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    self.navigationController.navigationBar.alpha = offsetY <= 0 ? 0:offsetY/250.0;
}
- (void)viewDidAppear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.alpha = 0.0;
    }];
}
//- (void)viewDidAppear:(BOOL)animated{
//    self.navigationController.navigationBar.alpha = 0.0;
//}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.alpha = 1.0;
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
