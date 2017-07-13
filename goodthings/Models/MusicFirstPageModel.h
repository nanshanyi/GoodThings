//
//  MusicFirstPageModel.h
//  goodthings
//
//  Create by  on 15/10/14.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BaseModel.h"

@class MusicAlbumModel,MusicAdModel,MusicPlayListModel,MusicMusicianModel;

@interface MusicFirstPageModel : BaseModel
+ (MusicFirstPageModel*)parseRespondData:(id)respondData;

@property (nonatomic, strong) NSArray<MusicMusicianModel *> *musicianArray;
@property (nonatomic, strong) MusicAlbumModel *albumModel;
@property (nonatomic, strong) NSArray<MusicAdModel *> *adModelArray;
@property (nonatomic, strong) NSArray<MusicPlayListModel *> *playListModelArray;
@end

@interface MusicMusicianModel : BaseModel
@property (nonatomic,   copy) NSString *title;
@property (nonatomic,   copy) NSString *mdescription;
@property (nonatomic,   copy) NSString *image;
@property (nonatomic,   copy) NSString *id;
@property (nonatomic,   copy) NSString *musiccode;
@end

@interface MusicAlbumModel : BaseModel
@property (nonatomic,   copy) NSString *mid;
@property (nonatomic,   copy) NSString *mcode;
@property (nonatomic,   copy) NSString *resourcecode;
@property (nonatomic,   copy) NSString *mnum;
@property (nonatomic,   copy) NSString *mname;
@property (nonatomic,   copy) NSString *mdesc;
@property (nonatomic,   copy) NSString *mphoto;
@property (nonatomic,   copy) NSString *play_count;

@end

@interface MusicAdModel : BaseModel
@property (nonatomic,   copy) NSString *id;
@property (nonatomic,   copy) NSString *image;
@property (nonatomic,   copy) NSString *flag;
@property (nonatomic,   copy) NSString *link;
@property (nonatomic,   copy) NSString *create_date;

@end

@interface MusicPlayListModel : BaseModel
@property (nonatomic,   copy) NSString *id;
@property (nonatomic,   copy) NSString *playlist_image;
@property (nonatomic,   copy) NSString *playlist_small_image;
@property (nonatomic,   copy) NSString *pimg;
@property (nonatomic,   copy) NSString *username;
@property (nonatomic,   copy) NSString *uid;
@property (nonatomic,   copy) NSString *playlist;
@property (nonatomic,   copy) NSString *playlist_name;
@property (nonatomic,   copy) NSString *status;
@property (nonatomic,   copy) NSString *create_date;
@property (nonatomic,   copy) NSString *desc;
@property (nonatomic,   copy) NSString *play_count;
@end
