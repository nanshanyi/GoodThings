//
//  SettingViewController.m
//  everyDay
//
//  Create by  on 15/10/6.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "SettingViewController.h"
#import "AdviceViewController.h"
#import "CustomTabBarController.h"
@interface SettingViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLable;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cusromNavBar];
    self.title = @"设置";
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
- (void)cusromNavBar{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
  [button setImageEdgeInsets:UIEdgeInsetsMake(11, 0, 11, 20)];
    [button setImage:[UIImage imageNamed:@"iconfont-chevronleftgreen"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = kGreenColor;
      UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)cleanCache:(id)sender {
    [GoodThingsCacheManager clearDisk];
    [[SDImageCache sharedImageCache] clearDisk];
    self.cacheSizeLable.text = @"0M";
}
- (IBAction)advice:(id)sender {
    AdviceViewController *adviceVC = [[AdviceViewController alloc]init];
    [self.navigationController pushViewController:adviceVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    CustomTabBarController *customTC = (CustomTabBarController*)self.tabBarController;
    [UIView animateWithDuration:0.2 animations:^{
        customTC.imageView.transform = CGAffineTransformTranslate(customTC.imageView.transform , 0, 50);
    } completion:^(BOOL finished) {
        
    }];
    NSInteger  imagecache = [[SDImageCache sharedImageCache] getSize];
    NSInteger cacheSize = [GoodThingsCacheManager CacheSize];
    float totalSize = (imagecache + cacheSize)/(1024.0*1024.0);
    self.cacheSizeLable.text = [NSString stringWithFormat:@"%.2fM",totalSize];
    self.cacheSizeLable.textColor = kBlueColor;
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
