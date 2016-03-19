//
//  MusicFormerViewController.h
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicFormerViewController: UIViewController
@property (nonatomic)UITableView *tableView;
@property (nonatomic)NSInteger pages;
@property (nonatomic)NSMutableArray *dataSourceArray;

@property (nonatomic) BOOL           isRefreshing;
@property (nonatomic) BOOL           isLoadingMore;

@property (nonatomic)LGHLoadingView *loadingView;

- (void)fetchDataFromNet;
- (void)endRefreshing;
- (void)parserData:(id)responsData;
- (void)registCell;
- (NSString *)composeRequestUrl;
- (void)creatTableView;
@end
