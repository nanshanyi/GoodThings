//
//  GoodGiftViewController.m
//  goodthings
//
//  Create by  on 15/10/12.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "GoodGiftViewController.h"
#import "GiftTableViewCell.h"
#import "CustomTabBarController.h"
#import "DetailViewController.h"
#import "JHRefresh.h"
#import "GiftModel.h"
@interface GoodGiftViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (nonatomic) UITableView    *tableView;
@property (nonatomic) NSMutableArray *dataSourceArray;
@property (nonatomic) NSInteger      page;
@property (nonatomic) BOOL           isRefreshing;
@property (nonatomic) BOOL           isLoadingMore;

@property (nonatomic) LGHLoadingView *loadingView;
@end

@implementation GoodGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好物";
    self.page = 0;
    [self creatTableView];
    [self addRefreshView];
    [self addLoadingView];
    [self fetchData];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}
- (void)creatTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    UINib *nib = [UINib nibWithNibName:@"GiftTableViewCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"giftCellId"];
    [self.view addSubview:self.tableView];
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
    NSString *url = [NSString stringWithFormat:kGiftUrl,self.page];
    if ([GoodThingsCacheManager isCacheDataInvalid:url]) {
        id respondData = [GoodThingsCacheManager readDataAtUrl:url];
        [self.loadingView removeLoadingView];
        [self parserData:respondData];
        [self.tableView reloadData];
        return YES;
    }
    return NO;
}
- (void)fetchDataFromNet{
    NSString *url = [NSString stringWithFormat:kGiftUrl,self.page];
    [[NetEngine sharedInstance] requestNewsListFrom:url success:^(id responsData) {
        [self parserData:responsData];
        [self.loadingView removeLoadingView];
        [self.tableView reloadData];
        [self endRefreshing];
    } falied:^(NSError *error) {
        [self.loadingView removeLoadingView];
        [self endRefreshing];
    }];
}
- (void)parserData:(id)responsData{
    if (self.page == 0) {
            NSString *url = [NSString stringWithFormat:kGiftUrl,self.page];
//         [GoodThingsCacheManager saveData:responsData atUrl:url];
        [self.dataSourceArray removeAllObjects];
        self.dataSourceArray = (NSMutableArray*)[GiftModel parseRespondData:responsData];
    }else{
        NSArray *array = [GiftModel parseRespondData:responsData];
        [self.dataSourceArray addObjectsFromArray:array];
    }
    GiftModel *model = [self.dataSourceArray lastObject];
    self.page = model.id;
}
#pragma mark - 刷新
- (void)addRefreshView{
    __weak typeof(self)weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.page = 0;
        weakSelf.isRefreshing = YES;
        [weakSelf fetchDataFromNet];
    }];
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isLoadingMore = YES;
       // [weakSelf fetchDataFromNet];
        [weakSelf fetchData];
    }];
}
- (void)endRefreshing
{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.tableView footerEndRefreshing];
    }
}

- (void)addLoadingView{

    self.loadingView = [[LGHLoadingView alloc]initWithFrame:CGRectMake(0,0 ,kScreenWidth, kScreenHeight-64) loadingViewStyle:RTSpinKitViewStyleWave AnimationViewcolor:kDarkGreenColor backGroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];

}

#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenWidth *300/375.0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"giftCellId"];
    if (cell == nil) {
        cell = [[GiftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"giftCellId"];
    }
    GiftModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    if (Version >= 9.0){
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
        
    }
    }
    [cell updateWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:kDetailUrl,model.id];
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.dataUrl = str;
    detailVC.imageUrl = model.guide_image[@"url"];
    [self.navigationController pushViewController:detailVC animated:YES];
    [self hiddenTabBar];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array =  tableView.indexPathsForVisibleRows;
    NSIndexPath *firstIndexPath = array[0];
    
    //设置anchorPoint
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    //为了防止cell视图移动，重新把cell放回原来的位置
    cell.layer.position = CGPointMake(0, cell.layer.position.y);
    
    //设置cell 按照z轴旋转90度，注意是弧度
    if (firstIndexPath.row < indexPath.row) {
            cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0);
    }else{
        cell.layer.transform = CATransform3DMakeRotation(- M_PI_2, 0, 0, 1.0);
    }

    cell.alpha = 0.0;
    
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - 3DTouch代理方法
- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    GiftModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:kDetailUrl,model.id];
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.dataUrl = str;
    detailVC.titlestr = @"品质";
    detailVC.imageUrl = model.guide_image[@"url"];
    return detailVC;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    //  self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
    [self hiddenTabBar];
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
