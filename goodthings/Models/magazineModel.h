//
//  magazineModel.h
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BaseModel.h"


@interface magazineModel : BaseModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger mid;

@property (nonatomic, copy) NSString *mname;

@property (nonatomic, copy) NSString *mdesc;

@property (nonatomic, assign) NSInteger cits;

@property (nonatomic, copy) NSString *resourcecode;

@property (nonatomic, copy) NSString *thumbnailUrl;

@property (nonatomic, assign) long long issuedate;

@property (nonatomic, assign) NSInteger hist;

@property (nonatomic, strong) NSArray *listud;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *field2;

@property (nonatomic, copy) NSString *ophoto;

@property (nonatomic, copy) NSString *mcode;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, copy) NSString *isshare;

@property (nonatomic, copy) NSString *mnum;

@property (nonatomic, copy) NSString *mphoto;

+ (NSArray*)parseRespondData:(id)respondData;
@end


