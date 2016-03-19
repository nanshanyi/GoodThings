//
//  CustomTableViewController.m
//  everyDay
//
//  Create by  on 15/10/5.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "CustomTabBarController.h"
#import "GoodGiftViewController.h"
#import "BeautifulViewController.h"
#import "GoodArticleViewController.h"
#import "GoodMusicViewController.h"

@interface CustomTabBarController ()
@property (nonatomic)UIView *slideView;

@property (nonatomic)NSArray *colorArray;


@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}
- (void)createContentViewControllers{

    BeautifulViewController *beautifulVC = [[BeautifulViewController alloc]init];
    UINavigationController *beautifulNav = [[UINavigationController alloc]initWithRootViewController:beautifulVC];

    
    GoodGiftViewController *goodGiftVC = [[GoodGiftViewController alloc]init];
    UINavigationController *goodGiftNav = [[UINavigationController alloc]initWithRootViewController:goodGiftVC];

    
//    GoodArticleViewController *goodArticleVC = [[GoodArticleViewController alloc]init];
//    UINavigationController *goodArticleNav = [[UINavigationController alloc]initWithRootViewController:goodArticleVC];
    GoodMusicViewController *goodMusicVC = [[GoodMusicViewController alloc]init];
    UINavigationController *goodMusicNav = [[UINavigationController alloc]initWithRootViewController:goodMusicVC];

    self.viewControllers = @[goodMusicNav,beautifulNav,goodGiftNav];
}
- (void)customTabBar
{
    //把自己的tabBar栏隐藏
    [self.tabBar setHidden:YES];
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    effectView.backgroundColor = [UIColor whiteColor];
    
//    effectView.contentView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    //使用UIImageView充当我们的背景
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    effectView.frame = self.imageView.bounds;
    [self.imageView addSubview:effectView];
    //backgroundView.image = [UIImage imageNamed:@"tab_black_bg@2x.png"];
    self.imageView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    self.slideView = [[UIView alloc]initWithFrame:CGRectMake(0, 49-2, kScreenWidth/3.0, 2)];
    self.slideView.backgroundColor = kBlueColor;
    [self.imageView addSubview:self.slideView];
    
 
    NSArray *titleArray = @[@"好听",@"好看",@"好物"];
    self.colorArray = @[kBlueColor,kGreenColor,kRedColor];
    CGFloat buttonWidth = kScreenWidth/self.viewControllers.count;
    CGFloat buttonHeight = 49;
    for (int index = 0; index < self.viewControllers.count;index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[titleArray objectAtIndex:index] forState:UIControlStateNormal];
        [button setTitleColor:kGrayColor forState:UIControlStateNormal];
        [button setTitleColor:self.colorArray[index] forState:UIControlStateSelected];
        NSString *normalImageName = [NSString stringWithFormat:@"iconfont_nomal%d",index];
        NSString *selectImageName = [NSString stringWithFormat:@"iconfont_select%d",index];
        
        //设置button上的字体的大小
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
        button.frame = CGRectMake(index*buttonWidth, 0, buttonWidth, buttonHeight);
        
        //对于button可以设置他image的内边距，也可以设置title的内边距，来调整button上文字和图片的位置
        //button.imageEdgeInsets 设置图片的内边距
        //button.titleEdgeInsets 设置title的内边距
        button.imageEdgeInsets = UIEdgeInsetsMake(5, 30, 18, 5);
        button.titleEdgeInsets = UIEdgeInsetsMake(30,-32, 0, 0);
        
        button.tag = 100 + index;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置初始显示时选中第一个按钮
        if (index == 0) {
            button.selected = YES;
        }
        
        [self.imageView addSubview:button];
    }
}

- (void)resetButtonStatus
{
    for (int index = 0; index < self.viewControllers.count; index++) {
        UIButton *button =  (UIButton*)[self.view viewWithTag:100+index];
        button.selected = NO;
    }
}

- (void)buttonClick:(UIButton*)button
{
    //重置button的状态
    [self resetButtonStatus];
    NSInteger index = button.tag - 100;
    
    //让button处于select状态
    button.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.slideView.center = CGPointMake(button.center.x, self.slideView.center.y);
        self.slideView.backgroundColor = self.colorArray[index];
    }];
    //修改UITabBarControler的selectedIndex ，会导致切换到对应的页面
    self.selectedIndex = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
