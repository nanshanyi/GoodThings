//
//  MusicFormerTableViewCell.h
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beautfulmodel.h"
@interface MusicFormerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *listenNumLable;
- (void)updateWithModel:(Beautfulmodel*)model;
@end
