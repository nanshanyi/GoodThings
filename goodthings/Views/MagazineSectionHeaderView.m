//
//  MagazineSectionHeaderView.m
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MagazineSectionHeaderView.h"

@interface MagazineSectionHeaderView ()

@property (nonatomic)BOOL isPlay;
@end

@implementation MagazineSectionHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier ]) {
        self.isPlay = NO;
        self.playButton.layer.cornerRadius = 30;
        self = [[[NSBundle mainBundle]loadNibNamed:@"MagazineSectionHeaderView" owner:self options:nil] lastObject];
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:tapgesture];
    }
    return self;
}

- (void)updateWithmodel:(magazineModel*)model{
    [self.magazineImageView sd_setImageWithURL:[NSURL URLWithString:model.mphoto]];
    self.titleLable.text = model.mname;
    self.termLable.text = [NSString stringWithFormat:@"第%@期",model.mnum];
    self.listenNumLable.text = [NSString stringWithFormat:@"%ld人听过",model.hist];
}
- (void)tapGesture:(UITapGestureRecognizer *)sender {
    if (self.block) {
        self.block ();
    }
}
- (IBAction)playMusic:(id)sender {
  
    if (self.playBlock) {
        self.playBlock ();
    }
}

@end














