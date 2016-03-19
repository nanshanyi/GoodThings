//
//  Beautfulmodel.m
//  goodthings
//
//  Create by 】 on 15/10/12.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "Beautfulmodel.h"

@implementation Beautfulmodel
@synthesize description = _description;


+ (NSArray*)parseRespondData:(id)respondData{
    NSMutableArray *array = [NSMutableArray array];
    for (id dic in respondData) {
//        Categorys *cat = [[Categorys alloc]init];
//        [cat setValuesForKeysWithDictionary:dic[@"category"]];
//        
//        Articledata *article = [[Articledata alloc]init];
//        [article setValuesForKeysWithDictionary:dic[@"articleData"]];
//        
//        Createby *creat = [[Createby alloc]init];
//        [creat setValuesForKeysWithDictionary:dic[@"createBy"]];
        
        Beautfulmodel *model = [[Beautfulmodel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
    

@end

//@implementation Createby
//
//@end
//
//
//@implementation Categorys
//
//@end
//
//
//@implementation Articledata
//
//@end
//
//
//
//
