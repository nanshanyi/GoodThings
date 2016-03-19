//
//  NetEngine.m
//  科技圈
//
//  Create by  on 15/9/19.
//  Copyright (c) 2015年 李国怀. All rights reserved.
//

#import "NetEngine.h"
#import "AFNetworking.h"

@interface NetEngine  ()
@property (nonatomic)AFHTTPSessionManager *manager;
@end

@implementation NetEngine
+ (instancetype)sharedInstance{
    static NetEngine *s_netManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_netManager = [[NetEngine alloc]init];
    });
    return s_netManager;
}
- (id)init{
    if (self = [super init]) {
        self.manager  = [[AFHTTPSessionManager alloc]init];
        NSSet *currentAcceptSet = self.manager.responseSerializer.acceptableContentTypes;
        NSMutableSet *mset = [NSMutableSet setWithSet:currentAcceptSet];
        [mset addObject:@"text/plain"];
        [mset addObject:@"text/json"];
        [mset addObject:@"application/json"];
        [mset addObject:@"text/html"];
        self.manager.responseSerializer.acceptableContentTypes = mset;
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    }
    return  self;
}

- (void)GET:(NSString*)url success:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock{
//    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            successBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}
- (void)requestNewsListFrom:(NSString*)url success:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock{
    [self GET:url success:successBlock falied:failedBlock];
}
- (void)GET2:(NSString*)url success:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock{
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSString *dataStr1 = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (dataStr1.length <= 0) {
                return;
            }
            NSString *dataStr2 = [dataStr1 substringWithRange:NSMakeRange(5, dataStr1.length-6)];
            NSData *data = [dataStr2 dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(array);
        }
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failedBlock) {
                failedBlock(error);
            }
        }];
}
- (void)requestDataFrom:(NSString*)url sucess:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock{
    NSURL *dataUrl = [NSURL URLWithString:url];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSError *error;
    NSString *dataStr1 = [NSString stringWithContentsOfURL:dataUrl encoding:NSUTF8StringEncoding error:&error];
        if (dataStr1.length <= 0) {
            return;
        }
        NSString *dataStr2 = [dataStr1 substringWithRange:NSMakeRange(5, dataStr1.length-6)];
        NSData *data = [dataStr2 dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (successBlock) {
            successBlock(array);
        }else{
            failedBlock(error);
        }
    });
}
@end
