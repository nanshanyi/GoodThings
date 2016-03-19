//
//  MusicFirstPageModel.h
//  goodthings
//
//  Create by  on 15/10/14.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BaseModel.h"

@interface MusicFirstPageModel : BaseModel
@property (nonatomic,assign)NSInteger id;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *image;
+ (NSArray*)parseRespondData:(id)respondData;
@end
