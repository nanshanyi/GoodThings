//
//  MagazineTableViewCell.h
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "songMenuModel.h"
@interface MagazineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *songNameLable;
@property (weak, nonatomic) IBOutlet UILabel *autherLable;

- (void)updateWithModel:(songMenuModel*)model;
@end
