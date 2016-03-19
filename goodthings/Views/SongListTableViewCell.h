//
//  SongListTableViewCell.h
//  goodthings
//
//  Create by  on 15/10/16.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "songMenuModel.h"
@interface SongListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numBerLabler;
@property (weak, nonatomic) IBOutlet UILabel *songNameLable;
@property (weak, nonatomic) IBOutlet UILabel *songerLabler;
@property (weak, nonatomic) IBOutlet UIView *gIfView;

@end
