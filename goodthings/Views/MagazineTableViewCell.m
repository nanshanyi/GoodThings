//
//  MagazineTableViewCell.m
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MagazineTableViewCell.h"

@interface MagazineTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation MagazineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)updateWithModel:(songMenuModel*)model{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.songNameLable.text = model.songname;
    self.autherLable.text = model.songer;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
