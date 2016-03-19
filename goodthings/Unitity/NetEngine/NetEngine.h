//
//  NetEngine.h
//  科技圈
//
//  Create by  on 15/9/19.
//  Copyright (c) 2015年 李国怀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^SuccessBlockType) (id responsData);
typedef void(^FailedBlockType)(NSError *error);

@interface NetEngine : NSObject
+ (instancetype)sharedInstance;
- (void)requestNewsListFrom:(NSString*)url success:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock;
- (void)GET2:(NSString*)url success:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock;
- (void)requestDataFrom:(NSString*)url sucess:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock;
@end



