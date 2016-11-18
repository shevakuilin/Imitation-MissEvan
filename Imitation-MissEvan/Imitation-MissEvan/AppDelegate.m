//
//  AppDelegate.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "AppDelegate.h"
#import "METabBarViewController.h"
#import "MEHeader.h"

@interface AppDelegate ()
{
    NSTimer * time;
}
@property (weak, nonatomic) UIView * launchView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    METabBarViewController * tabBar = [[METabBarViewController alloc] init];
    self.window.rootViewController = tabBar;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self customAppearance];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)customAppearance
{
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIViewController * viewController = ME_GetViewController(@"LaunchScreen", @"LaunchScreen");
    self.launchView = viewController.view;
    UIImageView  * Imageview= [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.launchView addSubview:Imageview];
    [self.window addSubview:self.launchView];
    [Imageview setImageWithURL:[NSURL URLWithString:@"http://static.missevan.com/mimages/201610/26/bf12252c78f3930b62cb71b2583b7bfb170900.png"] placeholderImage:[UIImage imageNamed:@""]];
    time = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeTick) userInfo:nil repeats:YES];
}

- (void)timeTick
{
    [time timeInterval];
    [self.launchView removeFromSuperview];
}

@end
