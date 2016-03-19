//
//  BaseCollectionViewController.m
//  goodthings
//
//  Create by  on 15/10/12.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//
#define ItemId @"itemId"

#import "BaseCollectionViewController.h"
#import "BeautifulCollectionViewCell.h"
#import "JHRefresh.h"
#import "CustomTabBarController.h"
#import "DetailViewController.h"

@interface BaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIViewControllerPreviewingDelegate>

@property (nonatomic)UICollectionView *collectionView;
@property (nonatomic)NSInteger pages;
@property (nonatomic)NSMutableArray *dataSourceArray;

@property (nonatomic) BOOL           isRefreshing;
@property (nonatomic) BOOL           isLoadingMore;

@property (nonatomic)LGHLoadingView *loadingView;

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pages = 1;
    self.isRefreshing=NO;
    self.isLoadingMore=NO;
    [self creatCollectionView];
    [self addRefreshView];
    [self addLoadingView];
    [self fetchData];
    
}
- (void)creatCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    flowLayout.itemSize = CGSizeMake(kItemWidth, kItemHeight);
   // flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kLightGrayColor;
    UINib *nib = [UINib nibWithNibName:@"BeautifulCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:ItemId];
    [self.view addSubview:self.collectionView];
    
}
- (void)fetchData{
    YYReachabilityStatus status = [YYReachability reachability].status;
    NSLog(@"%lu",(unsigned long)status);
    if(status == YYReachabilityStatusNone){
        [self fetchDataFromLocal];
    }else{
        [self fetchDataFromNet];
    }
}
- (BOOL)fetchDataFromLocal{
    NSString *url = [self composeRequestUrl];
    if ([GoodThingsCacheManager isCacheDataInvalid:url]) {
        id respondData = [GoodThingsCacheManager readDataAtUrl:url];
        [self.loadingView removeLoadingView];
        [self parserData:respondData];
        [self.collectionView reloadData];
        [self endRefreshing];
        return YES;
    }
    return NO;
}
- (void)fetchDataFromNet{
    NSString *url = [self composeRequestUrl];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[NetEngine sharedInstance] GET2:url success:^(id responsData) {
                [self parserData:responsData];
                [GoodThingsCacheManager saveData:responsData atUrl:url];
                [self.loadingView removeLoadingView];
                [self.collectionView reloadData];
                [self endRefreshing];
    } falied:^(NSError *error) {
        [self.loadingView removeLoadingView];
                [self endRefreshing];
    }];
//    [[NetEngine sharedInstance] requestDataFrom:url sucess:^(id responsData) {
//        [self parserData:responsData];
//        [GoodThingsCacheManager saveData:responsData atUrl:url];
//        [self.loadingView removeLoadingView];
////        [self.collectionView reloadData];
//        [self endRefreshing];
//    } falied:^(NSError *error) {
//        [self.loadingView removeLoadingView];
//        [self endRefreshing];
//    }];
}
- (void)parserData:(id)responsData{
    if (self.pages == 1) {
        [self.dataSourceArray removeAllObjects];
        self.dataSourceArray = (NSMutableArray*)[Beautfulmodel parseRespondData:responsData];
    }else{
        NSArray *array = [Beautfulmodel parseRespondData:responsData];
        [self.dataSourceArray addObjectsFromArray:array];
    }
 
}
- (NSString *)composeRequestUrl{
    return [NSString stringWithFormat:kBeautifulUrl,self.class_id,self.pages];
}
- (void)addLoadingView{
    
    self.loadingView = [[LGHLoadingView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) loadingViewStyle:RTSpinKitViewStyleWave AnimationViewcolor:kDarkGreenColor backGroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];
    
}
#pragma mark - 刷新
- (void)addRefreshView{
    __weak typeof(self)weakSelf = self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.pages = 1;
        weakSelf.isRefreshing = YES;
        [weakSelf fetchDataFromNet];
    }];
    [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.pages++;
        weakSelf.isLoadingMore = YES;
//        [weakSelf fetchDataFromNet];
        [weakSelf fetchData];
    }];
}
- (void)endRefreshing
{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.collectionView footerEndRefreshing];
    }
}

#pragma mark -
#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return self.dataSourceArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BeautifulCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemId forIndexPath:indexPath];
    Beautfulmodel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    [cell updateWithModel:model];
    if (Version >= 9.0){
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
        
    }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Beautfulmodel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.detailUrl = [NSString stringWithFormat:kArticleDetailUrl,model.id];
    detailVC.titlestr = model.title;
    detailVC.imageUrl = model.image;
    detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:detailVC animated:YES];
    [self hiddenTabBar];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row % 2 != 0) {
        cell.transform = CGAffineTransformTranslate(cell.transform, kScreenWidth/2, 0);
    }else{
        cell.transform = CGAffineTransformTranslate(cell.transform, -kScreenWidth/2, 0);
    }
    cell.alpha = 0.0;
    [UIView animateWithDuration:0.7 animations:^{
        cell.transform = CGAffineTransformIdentity;
        cell.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 3DTouch代理方法
- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:(UICollectionViewCell* )[previewingContext sourceView]];
    
    Beautfulmodel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.detailUrl = [NSString stringWithFormat:kArticleDetailUrl,model.id];
    detailVC.imageUrl = model.image;
    detailVC.titlestr = model.category[@"name"];
    detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    return detailVC;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
  //  self.navigationController.navigationBarHidden = YES;
   [self.navigationController pushViewController:viewControllerToCommit animated:YES];
    [self hiddenTabBar];
    
}
- (void)hiddenTabBar{
    CustomTabBarController *customTC = (CustomTabBarController*)self.tabBarController;
    [UIView animateWithDuration:0.3 animations:^{
        customTC.imageView.transform = CGAffineTransformTranslate(customTC.imageView.transform , 0, 50);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)viewDidAppear:(BOOL)animated{
    
    CustomTabBarController *customTC = (CustomTabBarController*)self.tabBarController;
    [UIView animateWithDuration:0.2 animations:^{
        customTC.imageView.transform = CGAffineTransformIdentity;
    }];
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
