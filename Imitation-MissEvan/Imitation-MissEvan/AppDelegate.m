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
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
{
    NSTimer * time;
    AVAudioPlayer * player;
    UIImageView  * imageView;
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
//    [[UINavigationBar appearance] setTranslucent:NO];
//    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
//    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    //配置默认主题
    [EAThemeManager shareManager].normalThemeIdentifier = EAThemeNormal;
    UITabBarController * rootViewController = (UITabBarController *)self.window.rootViewController;
    
    NSDictionary * tabBarColorDic = @{EAThemeBlack: ME_Color(32, 32, 32), EAThemeNormal: [UIColor whiteColor]};
    
    [rootViewController.tabBar ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        UITabBar * bar = (UITabBar *)currentView;
        bar.barTintColor = tabBarColorDic[currentThemeIdentifier];
    }];

    UIViewController * viewController = ME_GetViewController(@"LaunchScreen", @"LaunchScreen");
    self.launchView = viewController.view;
    imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"defaultStartImage"];
    [self.launchView addSubview:imageView];
    [self.window addSubview:self.launchView];
    
    time = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(addNetworkImageAndSound) userInfo:nil repeats:YES];
    
}

- (void)addNetworkImageAndSound
{
    [time invalidate];
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@%@.mp3", ME_URL_GLOBAL, ME_URL_SOUND, ME_SOUND_MIAO];
    NSURL * url = [[NSURL alloc]initWithString:urlStr];
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    //将数据保存到本地指定位置
    NSString * docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
    [audioData writeToFile:filePath atomically:YES];
    //播放本地音乐
    NSURL * fileURL = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [player play];
    
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@.png", ME_URL_GLOBAL, ME_URL_IMAGE, ME_IMAGE_START]] placeholderImage:[UIImage imageNamed:@""]];
    
    time = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timeTick) userInfo:nil repeats:YES];
}

- (void)timeTick
{
    [time invalidate];
    [player stop];
    [self.launchView removeFromSuperview];
}

@end
