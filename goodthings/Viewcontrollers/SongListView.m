//
//  SongListView.m
//  goodthings
//
//  Create by  on 15/10/16.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "SongListView.h"
#import "SongListTableViewCell.h"
#import "GifView.h"
@interface SongListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic)NSArray *dataSourceArray;
@property (nonatomic)NSInteger playingIndex;
@property (nonatomic)GifView *gifView;
@end

@implementation SongListView
- (id)initWithFrame:(CGRect)frame dataSourceArray:(NSArray*)array playingSongIndex:(NSInteger)index{
    if (self = [super initWithFrame:frame]) {
        self.dataSourceArray = array;
        self.playingIndex = index;
        self.backgroundColor = [UIColor clearColor];
        [self creatTableView];
    }
    return self;
}
- (void)creatTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kScreenHeight/4.0, kScreenWidth, kScreenHeight*3/4.0) style:UITableViewStyleGrouped];
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.opaque = NO;
    tableView.delegate = self;
    tableView.dataSource =self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SongListTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"SongListTableViewCell" owner:nil options:nil] lastObject];
    songMenuModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    cell.numBerLabler.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    cell.songNameLable.text = model.songname;
    cell.songerLabler.text = model.songer;
    if (indexPath.row == self.playingIndex) {
        self.gifView  =[[GifView alloc] initWithFrame:CGRectMake(0, 0, 20, 20) filePath:[[NSBundle mainBundle] pathForResource:@"music" ofType:@"gif"]];
        [cell.gIfView addSubview:self.gifView];
        cell.songNameLable.textColor = kDarkGreenColor;
        cell.songerLabler.textColor = kDarkGreenColor;
        cell.numBerLabler.text = nil;
    }else{
        //[self.gifView removeFromSuperview];
        cell.songNameLable.textColor = [UIColor blackColor];
        cell.songerLabler.textColor = [UIColor grayColor];
        cell.numBerLabler.textColor = [UIColor blackColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        self.block(indexPath.row);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
