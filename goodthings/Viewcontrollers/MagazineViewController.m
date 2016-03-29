//
//  MagazineViewController.m
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MagazineViewController.h"
#import "magazineModel.h"
#import "songMenuModel.h"
#import "MagazineTableViewCell.h"
#import "MagazineSectionHeaderView.h"
#import "MagazineFirstTableViewCell.h"
#import "CustomTabBarController.h"

#define MagazineTableViewCellId @"MagazineTableViewCellId"
#define MagazineFirstTableViewCellId @"MagazineFirstTableViewCellId"
@interface MagazineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic)NSMutableArray *allSongLisrtArray;

@property (nonatomic)NSMutableArray *isOpenArray;

@property (nonatomic)NSInteger      isplayingSection;

@property (nonatomic)NSInteger      isplayingIndex;

@property (nonatomic)BOOL           isPlaying;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
}
- (void)creatTableView{
    self.isplayingSection = 100;
    self.isPlaying = NO;
    self.isOpenArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registCell];
    [self.view addSubview:self.tableView];
}
- (void)registCell{
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"MagazineTableViewCell" bundle:nil] forCellReuseIdentifier:MagazineTableViewCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"MagazineFirstTableViewCell" bundle:nil] forCellReuseIdentifier:MagazineFirstTableViewCellId];
 
}
- (void)fetchDataFromNet{
    NSString *url = [self composeRequestUrl];
    [[NetEngine sharedInstance] requestNewsListFrom:url success:^(id responsData) {
        [self parserData:responsData];
         [GoodThingsCacheManager saveData:responsData atUrl:url];
        [self.loadingView removeLoadingView];
        [self.tableView reloadData];
        [self endRefreshing];
    } falied:^(NSError *error) {
        NSLog(@"%@",error);
         [self.loadingView removeLoadingView];
        [self endRefreshing];
    }];
}
- (void)parserData:(id)responsData{
    if (self.pages == 1) {
        [self.dataSourceArray removeAllObjects];
        self.dataSourceArray = (NSMutableArray*)[magazineModel parseRespondData:responsData];
        [self.allSongLisrtArray removeAllObjects];
        self.allSongLisrtArray = (NSMutableArray*)[songMenuModel parseRespondData:responsData];
    }else{
        NSArray *array = [magazineModel parseRespondData:responsData];
        [self.dataSourceArray addObjectsFromArray:array];
        NSArray *array1 = [songMenuModel parseRespondData:responsData];
        [self.allSongLisrtArray addObjectsFromArray:array1];
    }
    for (int index = 0 ; index < self.dataSourceArray.count; index++) {
        NSNumber *number = [NSNumber numberWithInteger:0];
        [self.isOpenArray addObject:number];
    }
}

- (NSString *)composeRequestUrl{
    return [NSString stringWithFormat:kmusicUrl,self.pages];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataSourceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    NSNumber *number = [self.isOpenArray objectAtIndex:section];
    if ([number integerValue] == 0) {
        return 0;
    }else{
        magazineModel *model = [self.dataSourceArray objectAtIndex:section];

    return model.list.count+1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScreenWidth*250/375.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
         magazineModel *model = [self.dataSourceArray objectAtIndex:indexPath.section];
     return [MagazineFirstTableViewCell contentHeight:model.mdesc];
    }
    return kScreenWidth *80/375.0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
    
       MagazineFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MagazineFirstTableViewCellId forIndexPath:indexPath];
        magazineModel *model = [self.dataSourceArray objectAtIndex:indexPath.section];
        [cell updateTextWithModel:model];
        
        return cell;
    }
    
    MagazineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MagazineTableViewCellId forIndexPath:indexPath];
    songMenuModel *model = [[self.allSongLisrtArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row-1];
    [cell updateWithModel:model];
    if (self.isplayingIndex == indexPath.row & self.isplayingSection == indexPath.section) {
        cell.songNameLable.textColor = kDarkGreenColor;
        cell.autherLable.textColor = kDarkGreenColor;
    }else{
        cell.autherLable.textColor = [UIColor darkGrayColor];
        cell.songNameLable.textColor = [UIColor blackColor];
    }
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MagazineSectionHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerId"];
    if (headView ==nil) {
        headView = [[MagazineSectionHeaderView alloc] initWithReuseIdentifier:@"headerId"];
                
          headView.frame  = CGRectMake(0, 0, kScreenWidth, kScreenWidth*250/375.0);
//        headView = [[MagazineSectionHeaderView alloc]initWithReuseIdentifier:@"headerId"];
//        headView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth*250/375.0);
    }
    magazineModel *model = [self.dataSourceArray objectAtIndex:section];
    [headView updateWithmodel:model];
    if (section == self.isplayingSection) {
         [headView.playButton setImage:[UIImage imageNamed:@"hunter_pause_up"] forState:UIControlStateNormal];
    }
    //播放按钮
    __weak typeof (headView) weakView = headView;
    headView.playBlock = ^(){
        NSArray *array = [self.allSongLisrtArray objectAtIndex:section];
        if (self.isplayingSection!=section) {
            self.isplayingIndex = 1;
        self.isplayingSection = section;
        //self.isPlaying = YES;
        [weakView.playButton setImage:[UIImage imageNamed:@"hunter_pause_up"] forState:UIControlStateNormal];
        [[ MusicPlayerViewController shareInstance]playMusicWithSongListArray:array magaZineModel:model index:0];
            [MusicPlayerViewController shareInstance].isPlaying = YES;
       
        }else{
            self.isplayingSection = 100;
            [[MusicPlayerViewController shareInstance].audioPlayer play];
            [MusicPlayerViewController shareInstance].isPlaying = NO;
        }
         [self.tableView reloadData];
    };
    //展开关闭
    headView.block = ^(){
        NSNumber *number = [self.isOpenArray objectAtIndex:section];
        if ([number integerValue] == 0) {
            [self.isOpenArray replaceObjectAtIndex:section withObject:@(1)];
        }else{
            [self.isOpenArray replaceObjectAtIndex:section withObject:@(0)];
        }
//        [self.tableView reloadData];
          [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];

    };
    return headView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isplayingSection = indexPath.section;
    self.isplayingIndex = indexPath.row;
    magazineModel *model = [self.dataSourceArray objectAtIndex:indexPath.section];
    NSArray *array = [self.allSongLisrtArray objectAtIndex:indexPath.section];
    [MusicPlayerViewController shareInstance].isPlaying = YES;
    [[ MusicPlayerViewController shareInstance]playMusicWithSongListArray:array magaZineModel:model index:indexPath.row-1];
    [self.tableView reloadData];
}
//- (void)viewWillappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self hiddenTabBar];
//}
//- (void)hiddenTabBar{
//    CustomTabBarController *customTC = (CustomTabBarController*)self.tabBarController;
//    [UIView animateWithDuration:0.3 animations:^{
//        customTC.imageView.transform = CGAffineTransformTranslate(customTC.imageView.transform , 0, 50);
//    } completion:^(BOOL finished) {
//        
//    }];
//}
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
