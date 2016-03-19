//
//  BaseModel.m
//  goodthings
//
//  Create by  on 15/10/12.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
   // NSLog(@"%@",key);
}
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
