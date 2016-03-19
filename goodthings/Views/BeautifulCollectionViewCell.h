//
//  BeautifulCollectionViewCell.h
//  goodthings
//
//  Create by  on 15/10/13.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beautfulmodel.h"
@interface BeautifulCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *categoryLable;
@property (weak, nonatomic) IBOutlet UILabel *autherLable;


- (void)updateWithModel:(Beautfulmodel*)model;
@end
