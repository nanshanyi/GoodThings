//
//  GiftModel.h
//  goodthings
//
//  Create by  on 15/10/13.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BaseModel.h"


@interface GiftModel : BaseModel

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, strong) NSDictionary *guide_image;

@property (nonatomic, strong) NSDictionary *author;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger publish_time;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *buy_url;

+ (NSArray*)parseRespondData:(id)respondData;
@end


