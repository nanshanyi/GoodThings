//
//  GoodMusicViewController.m
//  goodthings
//
//  Create by  on 15/10/13.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "GoodMusicViewController.h"
#import "MusicFirstPageModel.h"
#import "DetailViewController.h"
#import "MusicArticleViewController.h"
#import "MusicFormerViewController.h"
#import "CustomTabBarController.h"
#import "MagazineViewController.h"
#import "JHRefresh.h"
@interface GoodMusicViewController ()<UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLable1;
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView3;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *numLable;
@property (weak, nonatomic) IBOutlet UIImageView *lastImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic) LGHLoadingView *loadingView;
@property (nonatomic) MusicFirstPageModel *model1;
@property (nonatomic) MusicFirstPageModel *model2;
@property (nonatomic) MusicFirstPageModel *model3;
@property (nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation GoodMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLoadingView];
    [self fetchData];
    [self addRefreshView];
    self.title = @"好听";
    self.contentScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-64);
    
    // Do any additional setup after loading the view from its nib.
}
- (void)addRefreshView{
//    __weak typeof(self)weakSelf = self;
    [self.contentScrollView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        [self magazinePage];
         [self.contentScrollView footerEndRefreshing];
    }];
}
- (void)fetchData{
    if(![self fetchDataFromLocal]){
        [self fetchDataFromNet];
    }
}
- (BOOL)fetchDataFromLocal{
   
    if ([GoodThingsCacheManager isCacheDataInvalid:kmusicFirstPageUrl]) {
        id respondData1 = [GoodThingsCacheManager readDataAtUrl:kmusicFirstPageUrl];
        id respondData2 = [GoodThingsCacheManager readDataAtUrl:kmusicFirstPageUrl2];
        
        self.dataSourceArray = (NSMutableArray*)[MusicFirstPageModel parseRespondData:respondData1];
        [self customUI];
        NSDictionary *dic = [respondData2 lastObject];
        self.titleLable.text = dic[@"mname"];
        self.numLable.text = [NSString stringWithFormat:@"第%@期",dic[@"mnum"]];
        [self.lastImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"mphoto"]]];
        [self.loadingView removeLoadingView];
        return YES;
    }
    return NO;
}
- (void)fetchDataFromNet{
    
    [[NetEngine sharedInstance] requestNewsListFrom:kmusicFirstPageUrl success:^(id responsData) {
       self.dataSourceArray = (NSMutableArray*)[MusicFirstPageModel parseRespondData:responsData];
        [GoodThingsCacheManager saveData:responsData atUrl:kmusicFirstPageUrl];
        [self customUI];
    } falied:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
    [[NetEngine sharedInstance] requestNewsListFrom:kmusicFirstPageUrl2 success:^(id responsData) {
        [self.loadingView removeLoadingView];
        NSDictionary *dic = [responsData lastObject];
        self.titleLable.text = dic[@"mname"];
        self.numLable.text = [NSString stringWithFormat:@"第%@期",dic[@"mnum"]];
       [self.lastImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"mphoto"]]];
    [GoodThingsCacheManager saveData:responsData atUrl:kmusicFirstPageUrl2];
    } falied:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)customUI{
  
    self.model1 = [self.dataSourceArray objectAtIndex:0];
    self.titleLable1.text = self.model1 .title;
    [self.musicImageView1 sd_setImageWithURL:[NSURL URLWithString:self.model1 .image]];
    
    
    
    self.model2 = [self.dataSourceArray objectAtIndex:1];
    [self.musicImageView2 sd_setImageWithURL:[NSURL URLWithString:self.model2.image]];
    

    
    self.model3 = [self.dataSourceArray objectAtIndex:2];
    [self.musicImageView3 sd_setImageWithURL:[NSURL URLWithString:self.model3.image]];
    
if (Version >= 9.0){
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self registerForPreviewingWithDelegate:self sourceView:_musicImageView1];
        [self registerForPreviewingWithDelegate:self sourceView:_musicImageView2];
        [self registerForPreviewingWithDelegate:self sourceView:_musicImageView3];
        [self registerForPreviewingWithDelegate:self sourceView:self.lastImageView];
        
    }
}

}
- (IBAction)formerButton:(id)sender {
    MusicFormerViewController *musicFormerVC = [[MusicFormerViewController alloc]init];
    [self.navigationController pushViewController:musicFormerVC animated:YES];
   
    [self hiddenTabBar];
}
- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
    UIImageView *imageView = (UIImageView*)sender.view;
    if (imageView.tag == 13) {
        [self magazinePage];
    }else{
        MusicArticleViewController *detailVC = [[MusicArticleViewController alloc]init];
        MusicFirstPageModel *model = [self.dataSourceArray objectAtIndex:imageView.tag-kBaseTag];
        detailVC.musicPageUrl = [NSString stringWithFormat:kMusicDetailUrl,model.id];
//        detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:detailVC animated:YES completion:nil];
        [self.navigationController pushViewController:detailVC animated:YES];
        [self hiddenTabBar];
    }
}
- (void)magazinePage{
    MagazineViewController *magazineVC = [[MagazineViewController alloc]init];
    [self.navigationController pushViewController:magazineVC animated:YES];
    [self hiddenTabBar];
}
#pragma mark - 3DTouch代理方法
- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
   UIImageView *imageView = (UIImageView *)[previewingContext sourceView];
    
    if (imageView.tag == 13) {
        MagazineViewController *magazineVC = [[MagazineViewController alloc]init];
        return magazineVC;
    }else{
        MusicArticleViewController *detailVC = [[MusicArticleViewController alloc]init];
        MusicFirstPageModel *model = [self.dataSourceArray objectAtIndex:imageView.tag-kBaseTag];
        detailVC.musicPageUrl = [NSString stringWithFormat:kMusicDetailUrl,model.id];
        detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        return detailVC;
    }

}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    UIImageView *imageView = (UIImageView *)[previewingContext sourceView];
    if (imageView.tag == 13) {
        
        [self.navigationController pushViewController:viewControllerToCommit animated:YES];
         [self hiddenTabBar];
    }else{
         [self.navigationController pushViewController:viewControllerToCommit animated:YES];
        [self hiddenTabBar];
        
    }
    

}
- (void)addLoadingView{
    
    self.loadingView = [[LGHLoadingView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) loadingViewStyle:RTSpinKitViewStyleWave AnimationViewcolor:kDarkGreenColor backGroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];
    
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
