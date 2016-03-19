//
//  BeautifulCollectionViewCell.m
//  goodthings
//
//  Create by  on 15/10/13.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BeautifulCollectionViewCell.h"
@interface BeautifulCollectionViewCell ()

@end
@implementation BeautifulCollectionViewCell


- (void)awakeFromNib {
    //self.categoryLable.backgroundColor = kGreenColor;
    // Initialization code
}
- (void)updateWithModel:(Beautfulmodel*)model{
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:model.image ]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
   NSString *cate = model.category[@"name"];
    if ([cate isEqualToString:@"有品"]) {
        self.categoryLable.backgroundColor = kGreenColor;
    }else{
        self.categoryLable.backgroundColor = kBlueColor;
    }
    self.titleLable.text = model.title;
    self.categoryLable.text = cate;
    self.autherLable.text  = model.createBy[@"nickname"];
}

@end
