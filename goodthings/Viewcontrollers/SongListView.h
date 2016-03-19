//
//  SongListView.h
//  goodthings
//
//  Create by  on 15/10/16.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^playSongBlock)(NSInteger index);
@interface SongListView : UIView
@property (nonatomic,copy)playSongBlock block;
- (id)initWithFrame:(CGRect)frame dataSourceArray:(NSArray*)array playingSongIndex:(NSInteger)index;
@end
