//
//  MagazineFirstTableViewCell.m
//  goodthings
//
//  Create by  on 15/10/16.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MagazineFirstTableViewCell.h"

@interface MagazineFirstTableViewCell ()


@end

@implementation MagazineFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)updateTextWithModel:(magazineModel *)model{
    NSString *str = model.mdesc;
    NSMutableAttributedString *attributestr = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];
    [attributestr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    self.firstTextLable.attributedText = attributestr;
   // self.firstTextLable.text = model.mdesc;
}

+ (CGFloat)contentHeight:(NSString*)body
{
   // NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:body];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];
    CGRect rect = [body boundingRectWithSize:CGSizeMake(kScreenWidth-16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} context:nil];

    return rect.size.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end











