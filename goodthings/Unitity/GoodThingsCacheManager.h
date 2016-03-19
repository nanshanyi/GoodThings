//
//  ScienceCacheManager.h
//  科技圈3
//
//  Create by  on 15/9/26.
//  Copyright (c) 2015年 李国怀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodThingsCacheManager : NSObject

+ (void)saveData:(id)object atUrl:(NSString*)url;

+ (id)readDataAtUrl:(NSString*)url;

+ (BOOL)isCacheDataInvalid:(NSString*)url;

+ (NSInteger)CacheSize;

+ (void)clearDisk;
@end
