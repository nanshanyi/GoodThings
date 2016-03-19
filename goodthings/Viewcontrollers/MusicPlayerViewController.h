//
//  MusicPlayerViewController.h
//  goodthings
//
//  Create by  on 15/10/14.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioPlayer.h"
#import "songMenuModel.h"
#import "magazineModel.h"
@interface MusicPlayerViewController : UIViewController
@property (nonatomic,strong) AudioPlayer   *audioPlayer;
@property (nonatomic       ) BOOL          isPlaying;
@property (nonatomic,copy  ) NSString      *musicId;
@property (nonatomic,copy  ) songMenuModel *model;
+ (instancetype)shareInstance;
- (void)playMusicWithMusicId:(NSDictionary *)musicDic;
- (void)playMusicWithSongListArray:(NSArray*)songListArray magaZineModel:(magazineModel*)model index:(NSInteger)index;
- (IBAction)beginButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@end
