//
//  MusicPlayerViewController.m
//  goodthings
//
//  Create by  on 15/10/14.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MusicPlayerViewController.h"

#import "AudioStreamer.h"
#import "SongListView.h"
@interface MusicPlayerViewController ()
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *progressTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLable;



@property (nonatomic)      UIImageView  *autherImageView;
@property (nonatomic,copy) NSDictionary *articleMusicDic;
@property (nonatomic)      UILabel      *songNamelable;
@property (nonatomic)      UILabel      *songerLable;

@property (nonatomic)      NSArray      *songListArray;//歌单
@property (nonatomic)      magazineModel *magaModel;
@property (nonatomic)      NSNumber     *totalTime;//音乐总时间
@property (nonatomic)      NSNumber     *progressTime;//音乐进度时间


@property (nonatomic)      NSInteger    playingSongIndex;//记录当前播放的音乐

@property (nonatomic)      UIView       *listBackView;
@property (nonatomic)      SongListView *listView;
@end

@implementation MusicPlayerViewController

+ (instancetype)shareInstance{
     static MusicPlayerViewController *s_musicPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_musicPlayer = [[MusicPlayerViewController alloc]init];
    });
    return s_musicPlayer;
}
- (id)init{
    if (self = [super init]) {
        [self creatPlayer];
        self.isPlaying = NO;
     
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self customUI];
    [self customNavBar];
    [self addgesture];
  
    // Do any additional setup after loading the view from its nib.
}
- (void)addgesture{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGesture];
}
#pragma mark UI界面
- (void)customUI{

    self.autherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*200/375, kScreenWidth*200/375)];
    self.autherImageView.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0-100);
    self.autherImageView.layer.cornerRadius = (kScreenWidth*200/375)/2.0;
    self.autherImageView.layer.masksToBounds = YES;
    [self.view addSubview:self.autherImageView];
    
    self.songNamelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    self.songNamelable.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0+50);
   
    self.songNamelable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.songNamelable];
    
    self.songerLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    self.songerLable.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0+90);
   
    self.songerLable.font = [UIFont systemFontOfSize:14];
    self.songerLable.textColor = [UIColor grayColor];
    self.songerLable.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.songerLable];

    [self.progressSlider setThumbImage:[UIImage imageNamed:@"iconfont-sliderImage"] forState:UIControlStateNormal];
    self.progressTimeLable.text = @"0:00";
    self.totalTimeLable.text = @"0:00";
    if (self.articleMusicDic) {
        [self updateSongInfoWithDic];
        self.articleMusicDic = nil;
    }else{
      
        [self updateSongInfoWithIndex:self.playingSongIndex];
    }
}
- (void)customNavBar{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    headView.backgroundColor = kDarkGreenColor;
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2.0-50, 32, 100, 20)];
     lable.text = @"天天好音乐";
    [headView addSubview:lable];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, 66, 44);
    [button setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 33)];
    [button setImage:[UIImage imageNamed:@"iconfont-chevrondown"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:button];
    [self.view addSubview:headView];
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark 播放器

- (void)creatPlayer{
    if (self.audioPlayer == nil) {
        self.audioPlayer = [[AudioPlayer alloc] init];
    }
}

#pragma mark 文章音乐播放

- (void)playMusicWithMusicId:(NSDictionary *)musicDic{
    self.articleMusicDic = musicDic;
    [self playMusicWithUrl:self.articleMusicDic[@"filename"]];
    [self updateSongInfoWithDic];
//    NSString *url = [NSString stringWithFormat:kMusicDataUrl,musicId];
//    [[NetEngine sharedInstance] requestNewsListFrom:url success:^(id responsData) {
//        [self parserData:responsData];
//    } falied:^(NSError *error) {
//        
//    }];
}

- (void)parserData:(id)responsData{
    self.articleMusicDic = [responsData lastObject];
    
    [self playMusicWithUrl:self.articleMusicDic[@"filename"]];
    [self updateSongInfoWithDic];
    
}
- (void)playMusicWithUrl:(NSString*)url{

    [self.audioPlayer stop];
    self.audioPlayer.url = [NSURL URLWithString:url];
    [self.audioPlayer play];
    [self playAnimation];
    self.isPlaying = YES;
    
}

#pragma mark 播放控制

- (IBAction)beginButton:(UIButton *)sender {
    if (self.songListArray.count > 0||self.articleMusicDic != nil) {
       
    if (self.isPlaying) {
        self.isPlaying = NO;
        [sender setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
        [self pauseAnimation];
    }else{
        self.isPlaying = YES;
        [sender setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
        [self continueAnimation];
        }
        [self.audioPlayer play];
    }
}
//下一曲
- (IBAction)playNextSong:(id)sender {
    [self.playButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
    if (self.songListArray.count > 0 & self.playingSongIndex < self.songListArray.count-1) {
        self.playingSongIndex++;
        [self updateSongInfoWithIndex:self.playingSongIndex];
        songMenuModel *model = [self.songListArray objectAtIndex:self.playingSongIndex];
        [self playMusicWithUrl:model.filename];
    }else if (self.songListArray.count > 0 & self.playingSongIndex ==self.songListArray.count-1){
        self.playingSongIndex = 0;
        [self updateSongInfoWithIndex:self.playingSongIndex];
        songMenuModel *model = [self.songListArray objectAtIndex:self.playingSongIndex];
        [self playMusicWithUrl:model.filename];
    }else{
        
    }
    [self continueAnimation];
}

#pragma mark 旋转动画控制

- (void)playAnimation{
    CABasicAnimation  *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //旋转的是弧度
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue   = @(M_PI*2);
    rotationAnimation.duration  = 8;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    //这里指定一个key的目的是方便找到该动画
    
    [self.autherImageView.layer addAnimation:rotationAnimation forKey:@"playMusic"];
}
- (void)pauseAnimation{
    CFTimeInterval pausedTime = [self.autherImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.autherImageView.layer.speed = 0.0;
    self.autherImageView.layer.timeOffset = pausedTime;
}
- (void)continueAnimation{
    CFTimeInterval pausedTime = [self.autherImageView.layer timeOffset];
    self.autherImageView.layer.speed = 1.0;
    self.autherImageView.layer.timeOffset = 0.0;
    self.autherImageView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.autherImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.autherImageView.layer.beginTime = timeSincePause;
}

#pragma mark 显示歌单

- (IBAction)showSongList:(id)sender {
    if (self.songListArray.count > 0) {
        [self customSongListView];
    __weak typeof (self)weakSelf = self;
    self.listView.block = ^(NSInteger index){
        if (self.playingSongIndex != index) {
            [weakSelf updateSongInfoWithIndex:index];
            [weakSelf.playButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
            songMenuModel *model = [weakSelf.songListArray objectAtIndex:index];
            [weakSelf playMusicWithUrl:model.filename];
              weakSelf.playingSongIndex = index;
            weakSelf.isPlaying = YES;
            [weakSelf continueAnimation];
           
        }
        [UIView animateWithDuration:0.5 animations:^{
        weakSelf.listBackView.transform = CGAffineTransformIdentity;
        weakSelf.listView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [weakSelf.listBackView removeFromSuperview];
            [weakSelf.listView removeFromSuperview];
        }];
    };
    [UIView animateWithDuration:0.5 animations:^{
    self.listBackView.transform = CGAffineTransformTranslate(self.listBackView.transform, 0, -kScreenHeight);
        self.listView.transform = CGAffineTransformTranslate(self.listView.transform, 0, -kScreenHeight);
    }];
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        view.center = self.view.center;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        view.layer.cornerRadius = 3.0;
        UILabel *lable = [[UILabel alloc]initWithFrame:view.bounds];
        lable.font = [UIFont systemFontOfSize:15];
        lable.center = view.center;
        lable.text = @"只有一首哦，听听其他的吧";
        lable.textColor = [UIColor whiteColor];
        [self.view addSubview:view];
        [self.view addSubview:lable];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            view.alpha = 0.0;
            lable.alpha = 0.0;
        }completion:^(BOOL finished) {
             [view removeFromSuperview];
            [lable removeFromSuperview];
        }];
           
        });
    }
}
- (void)customSongListView{
    self.listBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.contentView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    effectView.frame = self.listBackView.bounds;
    
    [self.listBackView addSubview:effectView];
    [self.view addSubview:self.listBackView];
    
    self.listView = [[SongListView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight) dataSourceArray:self.songListArray playingSongIndex:self.playingSongIndex];
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 32, 44, 44)];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(11, 0, 11, 20)];
    [leftButton setImage:[UIImage imageNamed:@"iconfont-chevrondown"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(removeList) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    lable1.text = [NSString stringWithFormat:@"第%@期 | %@ 的歌单",self.magaModel.mnum,self.magaModel.mname];
    lable1.center = CGPointMake(self.view.center.x, kScreenHeight/4.0-50);
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    lable.textColor = [UIColor grayColor];
    lable.font = [UIFont systemFontOfSize:12];
    lable.text = [NSString stringWithFormat:@"共%ld首   %ld人听过",self.songListArray.count,self.magaModel.hist];
    lable.center = CGPointMake(self.view.center.x, kScreenHeight/4.0-20);
    [self.listView addSubview:lable1];
    [self.listView addSubview:lable];
    
    [self.listView addSubview:leftButton];
    [self.view addSubview:self.listView];
}
- (void)removeList{
    [UIView animateWithDuration:0.5 animations:^{
        self.listBackView.transform = CGAffineTransformIdentity;
        self.listView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.listView removeFromSuperview];
        [self.listBackView removeFromSuperview];
    }];
}
#pragma mark 歌单音乐播放
- (void)playMusicWithSongListArray:(NSArray*)songListArray magaZineModel:(magazineModel*)model index:(NSInteger)index{
    self.songListArray = songListArray;
    self.magaModel = model;
    self.playingSongIndex =index;
    [self updateSongInfoWithIndex:index];
     songMenuModel *songmodel = [self.songListArray objectAtIndex:self.playingSongIndex];
     [self playMusicWithUrl:songmodel.filename];
}

- (void)updateSongInfoWithIndex:(NSInteger)index{
    songMenuModel *model = [self.songListArray objectAtIndex:index];
    self.autherImageView.image = nil;
    [self.autherImageView sd_setImageWithURL:[NSURL URLWithString:model.songphoto] placeholderImage:[UIImage imageNamed:@"playing_bmwonboard_default"]];
    self.songNamelable.text = model.songname;
    self.songerLable.text = model.songer;

}
- (void)updateSongInfoWithDic{
      NSURL *imageUrl = [NSURL URLWithString:self.articleMusicDic[@"thumbnailUrl"]];
      [self.autherImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"playing_bmwonboard_default"]];
     self.songNamelable.text = self.articleMusicDic[@"songname"];
     self.songerLable.text = self.articleMusicDic[@"songer"];
}
#pragma mark -
#pragma mark 进度条更新
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"number"]) {
        NSNumber *number = [change objectForKey:NSKeyValueChangeNewKey];
        self.progressSlider.value = [number floatValue]/[self.totalTime floatValue];
        self.progressTimeLable.text = [self calculationTime:number];
        if ([self.totalTime integerValue]>0 & [number integerValue] > [self.totalTime integerValue]-1) {
            [self pauseAnimation];
            [self playNextSong:nil];
           
        }
        
    }else{
        self.totalTime = [change objectForKey:NSKeyValueChangeNewKey];
        self.totalTimeLable.text = [self calculationTime:self.totalTime];
    }
   
}
- (NSString*)calculationTime:(NSNumber*)second{
    NSInteger minutes = [second integerValue]/60;
    NSInteger seconds = [second integerValue]%60;
    NSString *timeStr = [NSString stringWithFormat:@"%ld:%02ld",minutes,seconds];
    return timeStr;
}
- (void)viewWillAppear:(BOOL)animated{
    if (self.isPlaying) {
        [self playAnimation];
        [self continueAnimation];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
    }else{
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
        [self pauseAnimation];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
