//
//  songMenuModel.h
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BaseModel.h"

@interface songMenuModel : BaseModel
@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger mid;

@property (nonatomic, copy) NSString *songname;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) NSString *resourcecode;

@property (nonatomic, copy) NSString *songer;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, copy) NSString *filename192;

@property (nonatomic, assign) NSInteger fsize;

@property (nonatomic, copy) NSString *thumbnailUrl;

@property (nonatomic, assign) NSInteger scnum;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *isshare;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *songphoto;

@property (nonatomic, assign) NSInteger status;

+ (NSArray*)parseRespondData:(id)respondData;
@end
