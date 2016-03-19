//
//  MagazineFirstTableViewCell.h
//  goodthings
//
//  Create by  on 15/10/16.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "magazineModel.h"
@interface MagazineFirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstTextLable;
- (void)updateTextWithModel:(magazineModel*)model;
+ (CGFloat)contentHeight:(NSString*)body;
@end
