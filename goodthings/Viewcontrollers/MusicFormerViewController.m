//
//  MusicFormerViewController.m
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MusicFormerViewController.h"
#import "MusicFormerTableViewCell.h"
#import "MusicArticleViewController.h"
#import "Beautfulmodel.h"
#import "JHRefresh.h"


@interface MusicFormerViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate,UIGestureRecognizerDelegate>

@end

@implementation MusicFormerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pages = 1;
    self.title = @"往期音乐";
    self.navigationController.interactivePopGestureRecognizer.delegate =self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self customNavbar];
    [self creatTableView];
    [self addRefreshView];
    [self addLoadingView];
    [self fetchData];
    
    // Do any additional setup after loading the view.
}

- (void)customNavbar{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 22, 22);
    [leftButton setImage:[UIImage imageNamed:@"iconfont-chevronleftgreen"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 22, 22);
    [rightButton setImage:[UIImage imageNamed:@"iconfont-vynildarkgreen"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(musicPlayer) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item2;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)musicPlayer{
    [self presentViewController:[MusicPlayerViewController shareInstance] animated:YES completion:nil];
}
- (void)creatTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    NSString *url = [self composeRequestUrl];
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
    NSString *url = [self composeRequestUrl];
    [[NetEngine sharedInstance]GET2:url success:^(id responsData) {
        [self parserData:responsData];
        [GoodThingsCacheManager saveData:responsData atUrl:url];
        [self.loadingView removeLoadingView];
        [self.tableView reloadData];
        [self endRefreshing];
    } falied:^(NSError *error) {
        [self endRefreshing];

    }];
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
#pragma mark - 刷新
- (void)addRefreshView{
    __weak typeof(self)weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.pages = 1;
        weakSelf.isRefreshing = YES;
        [weakSelf fetchDataFromNet];
    }];
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.pages++;
        weakSelf.isLoadingMore = YES;
        //[weakSelf fetchDataFromNet];
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

- (NSString *)composeRequestUrl{
    return [NSString stringWithFormat:kmusicFormerUrl,self.pages];
}
- (void)addLoadingView{
    
    self.loadingView = [[LGHLoadingView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) loadingViewStyle:RTSpinKitViewStyleWave AnimationViewcolor:kDarkGreenColor backGroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenWidth*250/375.0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicFormerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[MusicFormerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicArticleViewController *detailVC = [[MusicArticleViewController alloc]init];
    Beautfulmodel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    detailVC.musicPageUrl = [NSString stringWithFormat:kMusicDetailUrl,[model.id integerValue]];
    detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve ;
    [self.navigationController pushViewController:detailVC animated:YES ];
}

#pragma mark - 3DTouch代理方法
- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    
    MusicArticleViewController *detailVC = [[MusicArticleViewController alloc]init];
    Beautfulmodel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    detailVC.musicPageUrl = [NSString stringWithFormat:kMusicDetailUrl,[model.id integerValue]];
    detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve ;
    
    return detailVC;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    //  self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
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
