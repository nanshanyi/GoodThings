//
//  GiftTableViewCell.h
//  goodthings
//
//  Create by  on 15/10/13.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"
@interface GiftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UILabel *giftTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *giftDescribeLable;
- (void)updateWithModel:(GiftModel *)model;
@end
