//
//  BeautifulViewController.m
//  goodthings
//
//  Create by  on 15/10/12.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BeautifulViewController.h"
#import "Beautfulmodel.h"
#import "BaseCollectionViewController.h"
NSString *const kCachedTime = @"kCachedTime";
NSString *const kCachedVCName = @"kCachedVCName";
@interface BeautifulViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic)NSMutableArray *dataSourceArray;

@property (nonatomic)NSArray *titleArray;
@property (nonatomic)NSArray *categoryIdArray;
@property (nonatomic) NSMutableDictionary *viewControllersCaches;/**< 控制器缓存  */
@property (nonatomic)UIPageControl *pageControl;
@end

@implementation BeautifulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self creatcollectionView];
    [self creatPageControl];
    self.title = @"最新";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    self.pageControl.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.pageControl.hidden = YES;
}
- (void)initData{
    self.dataSourceArray  = [NSMutableArray array];
    self.titleArray = @[@"最新",@"有品",@"艺文"];
    self.categoryIdArray = @[@"28",@"650",@"29"];
}
- (void)creatcollectionView{
   
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
//    layout.sectionInset = UIEdgeInsetsMake(64, 0, 0, 0);
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
//    self.contentCollectionView.contentOffset = CGPointMake(0, -64);
    self.contentCollectionView.showsHorizontalScrollIndicator = NO;
    self.contentCollectionView.pagingEnabled = YES;
    self.contentCollectionView.dataSource = self;
    self.contentCollectionView.bounces = NO;
    self.contentCollectionView.delegate =self;
    self.contentCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"itemId"];
    
    [self.view addSubview:self.contentCollectionView];
}
- (void)creatPageControl{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,35, kScreenWidth, 5)];
//    self.pageControl.backgroundColor = kLightGrayColor;
    self.pageControl.numberOfPages = self.titleArray.count;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = kDarkGreenColor ;
    [self.navigationController.navigationBar addSubview:self.pageControl];
}
#pragma mark -
#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemId" forIndexPath:indexPath];
    BaseCollectionViewController *cachedViewController = (BaseCollectionViewController*)[self getCachedVCByIndexPath:indexPath];
    if (!cachedViewController) {
        
        cachedViewController = [[BaseCollectionViewController alloc]init];
        
        cachedViewController.class_id = [[self.categoryIdArray objectAtIndex:indexPath.item] integerValue];
    [self saveCachedVC:cachedViewController ByIndexPath:indexPath];
    }
    
    [self addChildViewController:cachedViewController];
    
    [cell addSubview:cachedViewController.view];
    // [cachedViewController didMoveToParentViewController:self];
    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.contentCollectionView) {
        NSInteger index = scrollView.contentOffset.x/kScreenWidth;
        self.pageControl.currentPage = index;
        self.title = self.titleArray[index];
    }
}
#pragma mark -
#pragma 缓存cachedViewController

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //从缓存中取出instaceController
    UIViewController *cachedViewController = [self getCachedVCByIndexPath:indexPath];
    if (!cachedViewController) {
        return;
    }
    //更新缓存时间
     //[self saveCachedVC:cachedViewController ByIndexPath:indexPath];
    //从父控制器中移除
    [cachedViewController removeFromParentViewController];
    [cachedViewController.view removeFromSuperview];
}
- (UIViewController *)getCachedVCByIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cachedDic = [self.viewControllersCaches objectForKey:@(indexPath.item)];
    UIViewController *cachedViewController = [cachedDic objectForKey:kCachedVCName];
    return cachedViewController;
}

- (void)saveCachedVC:(UIViewController *)viewController ByIndexPath:(NSIndexPath *)indexPath
{
   // NSDate *newTime =[NSDate date];
    NSDictionary *newCacheDic = @{
                                  kCachedVCName:viewController};
    [self.viewControllersCaches setObject:newCacheDic forKey:@(indexPath.item)];
}
- (NSMutableDictionary *)viewControllersCaches
{
    if (!_viewControllersCaches) {
        _viewControllersCaches = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _viewControllersCaches;
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
