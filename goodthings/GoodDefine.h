//
//  GoodDefine.h
//  goodthings
//
//  Create by  on 15/10/12.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#ifndef goodthings_GoodDefine_h
#define goodthings_GoodDefine_h

#define kBaseTag 10
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]

#define kScreenBounds   [UIScreen mainScreen].bounds
#define kScreenWidth  kScreenBounds.size.width*1.0
#define kScreenHeight kScreenBounds.size.height*1.0

#define kItemWidth (kScreenWidth-45)/2.0
#define kItemHeight (kScreenWidth-45)/2.0

#define kYellowColor [UIColor colorWithRed:251/255.0 green:203/255.0 blue:37/255.0 alpha:1]
#define kBlueColor [UIColor colorWithRed:11/255.0 green:194/255.0 blue:245/255.0 alpha:1]
#define kRedColor [UIColor colorWithRed:248/255.0 green:54/255.0 blue:72/255.0 alpha:1]
#define kGreenColor [UIColor colorWithRed:29/255.0 green:218/255.0 blue:175/255.0 alpha:1]
#define kDarkGreenColor [UIColor colorWithRed:101/255.0 green:193/255.0 blue:193/255.0 alpha:1]
#define kGrayColor [UIColor colorWithRed:153/255.0 green:169/255.0 blue:168/255.0 alpha:1]
#define kLightGrayColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
//好看页面接口
#define kBeautifulUrl @"http://wawa.fm/CmsSite/a/cms/article/mylist?category.id=%ld&pageNo=%ld&pageSize=20&uid=0&callback=data"
#define kArticleDetailUrl @"http://wawa.fm/apps/content_650.html?uid=0&id=%@"
//好礼界面
#define kGiftUrl @"http://api.yizhong.cccwei.com/api.php?srv=2001&cid=335975&uid=0&tms=20151012142734&sig=b86f05f130980515&wssig=83af15d1feb943c6&os_type=3&version=7&city_id=4&since_id=%ld&page_size=20"
#define kDetailUrl @"http://api.yizhong.cccwei.com/api.php?srv=2002&cid=335975&uid=0&tms=20151013180904&sig=b952237417a0c69e&wssig=a72c752261462d35&os_type=3&version=7&city_id=4&article_id=%ld"
//好听
#define kmusicFirstPageUrl @"http://wawa.fm/CmsSite/a/cms/article/myrnew?platform=wwiphone&uid=0"
//好听页最新一期期音乐
#define kmusicFirstPageUrl2 @"http://wawa.fm/CmsSite/a/cms/magazine/milist?platform=wwandroid&pageNo=1&pageSize=1"
//往期
#define kmusicFormerUrl @"http://wawa.fm/CmsSite/a/cms/article/mylist?category.id=543&pageNo=%ld&pageSize=10&uid=0&callback=data"
//好听页分期音乐全部数据
#define kmusicUrl @"http://wawa.fm/CmsSite/a/cms/magazine/milist?platform=wwandroid&pageNo=%ld&pageSize=15"
//音乐文章详情页
#define kMusicDetailUrl @"http://wawa.fm/apps/content_543.html?uid=0&id=%ld&deviceid=ffffffff-aef4-990c-7d81-599f4b989628&code=M"
//得到的json 内含音乐播放网址
#define kMusicDataUrl @"http://wawa.fm/CmsSite//a/cms/resource/mfindByIds?platform=wwandroid&ids=%@"
#endif
