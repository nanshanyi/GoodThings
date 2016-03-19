//
//  MusicFormerTableViewCell.m
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MusicFormerTableViewCell.h"

@implementation MusicFormerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self = [[[NSBundle mainBundle]loadNibNamed:@"MusicFormerTableViewCell" owner:nil options:nil] firstObject];
    return self;
}
- (void)updateWithModel:(Beautfulmodel *)model{
    [self.musicImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.songName.text = model.articleData[@"songname"];
    self.listenNumLable.text = [NSString stringWithFormat:@"%@",model.articleData[@"bfnum"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
