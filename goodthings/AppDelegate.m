//
//  AppDelegate.m
//  goodthings
//
//  Create by  on 15/10/12.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//        UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"设置" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
    
//        [UIApplication sharedApplication].shortcutItems = @[item];
    
    CustomTabBarController *tabBarController = [[CustomTabBarController alloc]init];
    [tabBarController createContentViewControllers];
    [tabBarController customTabBar];
    self.window = [[UIWindow alloc]initWithFrame:kScreenBounds];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler{
//通过shortcutItem.type来判断点击的是哪一个item，来进行不同的操作
    if ([shortcutItem.type isEqualToString:@"one"]) {
        UITabBarController *mytab = (UITabBarController*)self.window.rootViewController;
        mytab.selectedIndex = 0;
//    }else if ([shortcutItem.type isEqualToString:@"two"]){
////        SearchVC *searchVC = [[SearchVC alloc]init];
////        UITabBarController *mytab = (UITabBarController*)self.window.rootViewController;
////        UINavigationController *myNAV = [mytab.viewControllers firstObject];
////        [myNAV pushViewController:searchVC animated:YES];
////          [self.window.rootViewController presentViewController:searchVC animated:YES completion:nil];
//    }else{
////        FPHNearbyVC *vc = [[FPHNearbyVC alloc] init];
////        UITabBarController *mytab = (UITabBarController*)self.window.rootViewController;
////        UINavigationController *myNAV = [mytab.viewControllers firstObject];
////        vc.hidesBottomBarWhenPushed = YES;
////        [myNAV pushViewController:vc animated:YES];
    }
    completionHandler(YES);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
