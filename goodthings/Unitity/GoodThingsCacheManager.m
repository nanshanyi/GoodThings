//
//  ScienceCacheManager.m
//  科技圈3
//
//  Create by  on 15/9/26.
//  Copyright (c) 2015年 李国怀. All rights reserved.
//

#import "GoodThingsCacheManager.h"
#import "NSString+Hashing.h"

@implementation GoodThingsCacheManager

+(NSString*)cacheDirctory{
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cacheDir = [cacheDir stringByAppendingPathComponent:@"GoodThingsCache"];
    NSError *error;
    BOOL  bret = [[NSFileManager defaultManager] createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:&error];
    if (!bret) {
        return nil;
    }
    return cacheDir;
}
+ (NSString*)cacheFileFullPath:(NSString*)url{
    NSString *fileName = [url MD5Hash];
    NSString *cacheDir = [self cacheDirctory];
    return [cacheDir stringByAppendingPathComponent:fileName];
}
+ (void)saveData:(id)object atUrl:(NSString*)url{
    NSString *fileFullPath = [self cacheFileFullPath:url];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [data writeToFile:fileFullPath atomically:YES];
    
}

+ (id)readDataAtUrl:(NSString*)url{
    NSString *filFullPath  = [self cacheFileFullPath:url];
    NSData *data = [NSData dataWithContentsOfFile:filFullPath];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (BOOL)isCacheDataInvalid:(NSString*)url{
    NSString *filFullPath  = [self cacheFileFullPath:url];
    BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:filFullPath isDirectory:nil];
    NSDictionary *attributeDic = [[NSFileManager defaultManager]attributesOfItemAtPath:filFullPath error:nil];
    NSDate *lastCacheDate = attributeDic.fileModificationDate;
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:lastCacheDate];
    BOOL isExpire = (timeInterval > 60*60);
    if (isFileExist && !isExpire) {
        return YES;
    }
    return NO;
}

+ (NSInteger)CacheSize{
    NSInteger totalSize = 0;
    NSString *cacheDir = [self cacheDirctory];
    NSDirectoryEnumerator *enmuerator = [[NSFileManager defaultManager]enumeratorAtPath:cacheDir];
    for (NSString *filename in enmuerator) {
        NSString *fileFullPath = [cacheDir stringByAppendingPathComponent:filename];
        NSDictionary *attributeDic = [[NSFileManager defaultManager]attributesOfItemAtPath:fileFullPath error:nil];
        totalSize += attributeDic.fileSize;
    }
    return totalSize;
}

+ (void)clearDisk{
    NSString *cacheDir = [self cacheDirctory];
    [[NSFileManager defaultManager] removeItemAtPath:cacheDir error:nil];
}
@end

















