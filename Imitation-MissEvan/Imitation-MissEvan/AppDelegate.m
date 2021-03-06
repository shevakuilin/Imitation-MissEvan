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
    [self networkMonitoring];
    [self otherSetting];
    
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

- (void)otherSetting
{
    //注册后台播放
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
}

- (void)networkMonitoring
{
    //网络监控句柄
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //status:
        //AFNetworkReachabilityStatusUnknown          = -1,  未知
        //AFNetworkReachabilityStatusNotReachable     = 0,   未连接
        //AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G
        //AFNetworkReachabilityStatusReachableViaWiFi = 2,   无线连接
        
        switch (status) {
            case -1:
                MELog(@"未知网络");
                [MEUtil showHubWithTitle:@"未知网络"];
                break;
            case 0:
                MELog(@"无网络");
                [MEUtil showHubWithTitle:@"无网络"];
                break;
            case 1:
                MELog(@"2G/3G/4G网络");
                [MEUtil showHubWithTitle:@"当前2G/3G/4G网络"];
                break;
            case 2:
                MELog(@"wifi连接");
                [MEUtil showHubWithTitle:@"wifi已连接"];
                break;
                
            default:
                break;
        }
        
    }];

}

- (void)customAppearance
{
    //设置主题对tabBar的影响
    UITabBarController * rootViewController = (UITabBarController *)self.window.rootViewController;
    
    NSDictionary * tabBarColorDic = @{EAThemeBlack: ME_Color(32, 32, 32), EAThemeNormal: [UIColor whiteColor]};
    
    [rootViewController.tabBar ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        UITabBar * bar = (UITabBar *)currentView;
        bar.barTintColor = tabBarColorDic[currentThemeIdentifier];
    }];
    
    //获取主题记录
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * eathemStyle = [userDefaults objectForKey:@"EAThemeStyle"];
    if (eathemStyle) {//如果有记录，那么根据记录设置主题
        if ([eathemStyle isEqualToString:EAThemeNormal]) {
            ME_ThemeManage.normalThemeIdentifier = EAThemeNormal;
        } else {
            ME_ThemeManage.normalThemeIdentifier = EAThemeBlack;
        }
    } else {//如果没有则设置默认主题
        //配置默认主题
        ME_ThemeManage.normalThemeIdentifier = EAThemeNormal;
    }

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
