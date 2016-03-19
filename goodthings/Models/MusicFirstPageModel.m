//
//  MusicFirstPageModel.m
//  goodthings
//
//  Create by  on 15/10/14.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MusicFirstPageModel.h"

@implementation MusicFirstPageModel
+ (NSArray*)parseRespondData:(id)respondData{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in respondData) {
        MusicFirstPageModel *model = [[MusicFirstPageModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
