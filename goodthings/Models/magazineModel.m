//
//  magazineModel.m
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "magazineModel.h"

@implementation magazineModel

+ (NSArray*)parseRespondData:(id)respondData{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in respondData) {
        magazineModel *model = [[magazineModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}


@end



