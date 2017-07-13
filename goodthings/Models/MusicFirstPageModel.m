//
//  MusicFirstPageModel.m
//  goodthings
//
//  Create by  on 15/10/14.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MusicFirstPageModel.h"

@implementation MusicFirstPageModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"musicianArray":@"musician",
             @"albumModel":@"album",
             @"adModelArray":@"ad",
             @"playListModelArray":@"playlist"
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"musicianArray":[MusicMusicianModel class],
             @"adModelArray":[MusicAdModel class],
             @"playListModelArray":[MusicPlayListModel class]
             };
}
+ (MusicFirstPageModel*)parseRespondData:(id)respondData{
    MusicFirstPageModel *model = [MusicFirstPageModel yy_modelWithJSON:respondData];
    return model;
}
@end
@implementation MusicMusicianModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"mdescription":@"description",
             };
}

@end

@implementation MusicAlbumModel




@end

@implementation MusicAdModel



@end

@implementation MusicPlayListModel



@end
