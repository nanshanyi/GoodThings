//
//  GiftModel.m
//  goodthings
//
//  Create by  on 15/10/13.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "GiftModel.h"

@implementation GiftModel

+ (NSArray*)parseRespondData:(id)respondData{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *array1 = respondData[@"data"][@"items"];
    for (NSDictionary *dic in array1) {
        GiftModel *model = [[GiftModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        if ([model.guide_image isKindOfClass:[NSDictionary class]]) {
               [array addObject:model];
        }
    }
    return array;
}

@end



