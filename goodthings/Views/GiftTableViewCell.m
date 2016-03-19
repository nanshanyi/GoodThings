//
//  GiftTableViewCell.m
//  goodthings
//
//  Create by  on 15/10/13.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "GiftTableViewCell.h"

@implementation GiftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [[[NSBundle mainBundle]loadNibNamed:@"GiftTableViewCell" owner:nil options:nil] firstObject];
    return self;
}
- (void)updateWithModel:(GiftModel *)model{
    NSURL *url = [NSURL URLWithString:model.guide_image[@"url"]];
    [self.giftImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.giftTitleLable.text = model.title;
    self.giftDescribeLable.text = model.introduction;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
