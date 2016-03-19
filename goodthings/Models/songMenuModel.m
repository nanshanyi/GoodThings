//
//  songMenuModel.m
//  goodthings
//
//  Create by  on 15/10/15.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "songMenuModel.h"

@implementation songMenuModel
+ (NSArray*)parseRespondData:(id)respondData{
    NSMutableArray *array0 = [NSMutableArray array];
   
    for (NSDictionary *dic1 in respondData) {
         NSArray *array1 = dic1[@"list"];
        NSMutableArray *array2 = [NSMutableArray array];
        for (NSDictionary *dic2 in array1) {
            songMenuModel *model = [[songMenuModel alloc]init];
            [model setValuesForKeysWithDictionary:dic2];
            [array2 addObject:model];
        }
        [array0 addObject:array2];
    }
    return array0;
}
@end
