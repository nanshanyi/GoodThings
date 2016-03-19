//
//  Beautfulmodel.h
//  goodthings
//
//  Create by 】 on 15/10/12.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BaseModel.h"

//@class Createby,Categorys,Articledata;
@interface Beautfulmodel : BaseModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) NSDictionary *category;

@property (nonatomic, copy) NSString *description;

@property (nonatomic, assign) NSInteger sits;

@property (nonatomic, copy) NSString *isdz;

@property (nonatomic, assign) NSInteger zits;

@property (nonatomic, assign) NSInteger cits;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, assign) NSInteger isgz;

@property (nonatomic, strong) NSDictionary *articleData;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *articleUrl;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, assign) NSInteger hits;

@property (nonatomic, copy) NSString *isshare;

@property (nonatomic, strong) NSDictionary *createBy;

+ (NSArray*)parseRespondData:(id)respondData;
@end
//@interface Createby : NSObject
//
//@property (nonatomic, copy) NSString *pimg;
//
//@property (nonatomic, assign) NSInteger uid;
//
//@property (nonatomic, copy) NSString *remark;
//
//@property (nonatomic, copy) NSString *nickname;
//
//@property (nonatomic, copy) NSString *card;
//
//@property (nonatomic, copy) NSString *subscription;
//
//@property (nonatomic, assign) NSInteger artnum;
//
//@property (nonatomic, strong) NSArray *bqname;
//
//@property (nonatomic, assign) NSInteger fsnum;
//
//@property (nonatomic, copy) NSString *lanmu;
//
//@end
//
//@interface Categorys : NSObject
//
//@property (nonatomic, copy) NSString *id;
//
//@property (nonatomic, copy) NSString *createDate;
//
//@property (nonatomic, copy) NSString *name;
//
//@property (nonatomic, copy) NSString *updateDate;
//
//@end
//
//@interface Articledata : NSObject
//
//@property (nonatomic, assign) NSInteger time;
//
//@property (nonatomic, copy) NSString *id;
//
//@property (nonatomic, assign) NSInteger apptype;
//
//@property (nonatomic, assign) NSInteger rid;
//
//@property (nonatomic, copy) NSString *allowComment;
//
//@property (nonatomic, assign) NSInteger bfnum;
//
//@property (nonatomic, assign) NSInteger youpintype;
//
//@end
//
