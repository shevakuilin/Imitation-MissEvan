//
//  MEDataSource.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEDataSource.h"

@implementation MEDataSource

+ (MEDataSource *)shareDataSource
{
    static MEDataSource * sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        sharedSingleton = [[self alloc] init];
        [sharedSingleton dataSourceOfTabBar];
        [sharedSingleton dataSourceOfSegment];
        [sharedSingleton dataSourceOfHomeRecommend];
    });
    return sharedSingleton;
}

- (void)dataSourceOfTabBar
{
    self.imageNameArray = [[NSArray alloc] initWithObjects:@"homepage", @"channel", @"", @"follow", @"mine", nil];
    self.barTitleArray = [[NSArray alloc] initWithObjects:@"首页", @"频道", @"", @"关注", @"我的", nil];
}

- (void)dataSourceOfSegment
{
    self.segmentTitleArray = [[NSArray alloc] initWithObjects:@"音单", @"推荐", @"分类", nil];
}

- (void)dataSourceOfHomeRecommend
{
    self.homeTopImageDic = @{@"activity": @"hp3_icon_activity_40x40_",
                             @"channel": @"hp3_icon_channel_41x40_",
                             @"mission": @"hp3_icon_mission_40x40_",
                             @"rank": @"hp3_icon_rank_41x40_",
                             @"activity_title": @"活动",
                             @"rank_title": @"排行",
                             @"channel_title": @"广播剧",
                             @"mission_title": @"任务"};
    
    self.hotCellDic = @{@"image": @"hp3_icon_msound_small_26x26_",
                        @"title": @"人气M音"};
}
@end
