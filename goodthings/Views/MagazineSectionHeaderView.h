//
//  MagazineSectionHeaderView.h
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "magazineModel.h"

typedef void (^tapGestureBlock) (); //(NSInteger tag);
typedef void (^playMusicBlock) ();
@interface MagazineSectionHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *termLable;
@property (weak, nonatomic) IBOutlet UILabel *listenNumLable;
@property (weak, nonatomic) IBOutlet UIImageView *magazineImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic,copy)tapGestureBlock block;
@property (nonatomic,copy)playMusicBlock playBlock;
- (void)updateWithmodel:(magazineModel*)model;
@end
