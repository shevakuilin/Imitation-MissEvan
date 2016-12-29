//
//  MEDataSource.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEDataSource.h"
#import "MEHeader.h"

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
        [sharedSingleton dataSourceOfVoiceList];
        [sharedSingleton dataSourceOfClassify];
        [sharedSingleton dataSourceOfMy];
        [sharedSingleton dataSourceOfOther];
    });
    return sharedSingleton;
}

- (void)dataSourceOfTabBar
{
//    self.imageNameArray = [[NSArray alloc] initWithObjects:@"homepage", @"channel", @"", @"follow", @"mine", nil];
//    self.barTitleArray = [[NSArray alloc] initWithObjects:@"首页", @"频道", @"", @"关注", @"我的", nil];
    self.imageNameArray = [[NSArray alloc] initWithObjects:@"homepage", @"channel", @"follow", @"mine", nil];
    self.barTitleArray = [[NSArray alloc] initWithObjects:@"首页", @"频道", @"关注", @"我的", nil];
}

- (void)dataSourceOfSegment
{
    self.segmentTitleArray = [[NSArray alloc] initWithObjects:@"音单", @"推荐", @"分类", nil];
}

- (void)dataSourceOfHomeRecommend
{
//    self.homeTopArray = @[@{@"image":@"hp3_icon_activity_40x40_", @"title":@"活动"},
//                          @{@"image":@"hp3_icon_rank_41x40_", @"title":@"排行"},
//                          @{@"image":@"hp3_icon_channel_41x40_", @"title":@"广播剧"},
//                          @{@"image":@"hp3_icon_mission_40x40_", @"title":@"任务"}];
    //v.3.7.0 -
    self.bannerArray = @[@{@"image":@"http://static.missevan.com/mimages/201612/15/762273f7bd88e4d46442fdcd0c7da0ac103315.png"},
                         @{@"image":@"http://static.missevan.com/mimages/201612/08/ab6a95e94933d5488b70dd872d2e1d16143051.jpg"},
                         @{@"image":@"http://static.missevan.com/mimages/201612/16/ce5e17b747c0cc985d68276fbf3a2e17103110.png"},
                         @{@"image":@"http://static.missevan.com/mimages/201612/08/87429797a90c4854ef1bdc9b6acc90ed155822.png"}];
    
    self.homeTopArray = @[@{@"image":@"nhp_title_topic_40x40_", @"title":@"专题"},
                          @{@"image":@"nhp_title_rank_40x40_", @"title":@"排行"},
                          @{@"image":@"nhp_title_drama_40x40_", @"title":@"广播剧"},
                          @{@"image":@"nhp_title_mission_40x40_", @"title":@"任务"}];
    
    self.homeTopNightArray = @[@{@"image":@"nhp_title_topic_night_40x40_", @"title":@"专题"},
                          @{@"image":@"nhp_title_rank_night_40x40_", @"title":@"排行"},
                          @{@"image":@"nhp_title_drama_night_40x40_", @"title":@"广播剧"},
                          @{@"image":@"nhp_title_mission_night_40x40_", @"title":@"任务"}];
    
    
    self.bellArray = @[@{@"image":@"hp3_title_bell2_40x40_", @"title":@"闹铃"},
                       @{@"image":@"hp3_title_message2_40x40_", @"title":@"短信"},
                       @{@"image":@"hp3_title_phone2_40x40_", @"title":@"来电"},
                       @{@"image":@"hp3_title_sleep2_40x40_", @"title":@"催眠"}];
    
    self.bellNightArray = @[@{@"image":@"hp3_title_bell2_night_40x40_", @"title":@"闹铃"},
                       @{@"image":@"hp3_title_message2_night_40x40_", @"title":@"短信"},
                       @{@"image":@"hp3_title_phone2_night_40x40_", @"title":@"来电"},
                       @{@"image":@"hp3_title_sleep2_night_40x40_", @"title":@"催眠"}];
    
    self.akiraArray = @[@{@"image":@"梶裕贵", @"name":@"梶裕贵"},
                        @{@"image":@"小野大辅", @"name":@"小野大辅"},
                        @{@"image":@"花江夏树", @"name":@"花江夏树"},
                        @{@"image":@"钉宫理惠-1.jpg", @"name":@"钉宫理惠"}];
    
    self.topCellArray = @[@{@"image": @"hp3_icon_msound_small_26x26_",
                          @"title": @"人气M音"},
                        @{@"image": @"hp3_icon_channel_small_26x27_",
                          @"title": @"频道"},
                        @{@"image": @"hp3_icon_album_small_26x26_",
                          @"title": @"音单"},
                        @{@"image": @"hp3_icon_ring_small_26x26_",
                          @"title": @"铃声"},
                        @{@"image": @"hp3_icon_seiyu_small_26x26_",
                          @"title": @"推荐声优"},
                        @{@"image": @"hp3_icon_5_26x26_",
                          @"title": @"广播剧"}];
    
    self.topCellNightArray = @[@{@"image": @"hp3_icon_msound_small_night_26x26_",
                            @"title": @"人气M音"},
                          @{@"image": @"hp3_icon_channel_small_night_26x26_",
                            @"title": @"频道"},
                          @{@"image": @"hp3_icon_album_small_night_26x26_",
                            @"title": @"音单"},
                          @{@"image": @"hp3_icon_ring_small_night_26x26_",
                            @"title": @"铃声"},
                          @{@"image": @"hp3_icon_seiyu_small_night_26x26_",
                            @"title": @"推荐声优"},
                          @{@"image": @"hp3_icon_5_night_26x26_",
                            @"title": @"广播剧"}];

    
    self.recommendCellArray = @[@{@"themes_image": @"hotMVoice_topLeft",
                                  @"title": @"ACG周刊-25期-你的名字终于要播...",
                                  @"played_count": @"3841",
                                  @"words_count": @"37"},
                                @{@"themes_image": @"hotMVoice_topCenter",
                                  @"title": @"【3D环绕】Alan Walker - Faded",
                                  @"played_count": @"4879",
                                  @"words_count": @"38"},
                                @{@"themes_image": @"hotMVoice_topRight",
                                  @"title": @"游术评（使命召唤系列）《使命召唤》",
                                  @"played_count": @"3586",
                                  @"words_count": @"14"},
                                @{@"themes_image": @"hotMVoice_downLeft",
                                  @"title": @"【少年霜】世末歌者",
                                  @"played_count": @"3686",
                                  @"words_count": @"21"},
                                @{@"themes_image": @"hotMVoice_downCenter",
                                  @"title": @"【请爱我到时光尽头】“愿你了解...",
                                  @"played_count": @"3789",
                                  @"words_count": @"18"},
                                @{@"themes_image": @"hotMVoice_downRight",
                                  @"title": @"【3D】刀剑乱舞 花丸-心魂の在処",
                                  @"played_count": @"3924",
                                  @"words_count": @"13"}];

    self.channelCellArray = @[@{@"themes_image": @"日常精分现场",
                                @"title": @"日常精分现场",
                                @"played_count": @"1866"},
                              @{@"themes_image": @"剑网3",
                                @"title": @"剑网3",
                                @"played_count": @"2076"},
                              @{@"themes_image": @"震撼心灵的史诗音乐",
                                @"title": @"震撼心灵的史诗音乐",
                                @"played_count": @"325"},
                              @{@"themes_image": @"那些魔性的翻唱",
                                @"title": @"那些魔性的翻唱",
                                @"played_count": @"85"}];
    
    
    self.radioArray = @[@{@"themes_image": @"暴龙小猫咪",
                          @"title": @"现代耽美广播剧【我的暴龙小猫咪】全一期",
                          @"played_count": @"1010",
                          @"words_count": @"8"},
                        @{@"themes_image": @"足下的恋人",
                          @"title": @"【BD·SM慎入】《足下的恋人》第三期",
                          @"played_count": @"630",
                          @"words_count": @"2"},
                        @{@"themes_image": @"渣攻",
                          @"title": @"渣功重生手册第一期",
                          @"played_count": @"177",
                          @"words_count": @"0"}];
    
    self.hotWordsArray = @[@{@"hotwords":@"高能"},
                           @{@"hotwords":@"娇喘"},
                           @{@"hotwords":@"asmr"},
                           @{@"hotwords":@"佐藤拓也"},
                           @{@"hotwords":@"黑猫男友"},
                           @{@"hotwords":@"慎"},
                           @{@"hotwords":@"ten"},
                           @{@"hotwords":@"古川慎"},
                           @{@"hotwords":@"count"},
                           @{@"hotwords":@"平川大辅"}];
    
}

- (void)dataSourceOfVoiceList
{
    self.voiceListArray = @[@{@"themes_image": @"心灵的旋律",
                              @"title": @"【节奏纯音】心灵的旋律",
                              @"voice_count": @"34"},
                            @{@"themes_image": @"岁月如酒，江湖如歌",
                              @"title": @"【古风】岁月如酒，江湖如歌",
                              @"voice_count": @"19"},
                            @{@"themes_image": @"3D耳机音乐盛宴",
                              @"title": @"【3D大碟】3D耳机音乐盛宴 纵享狂欢",
                              @"voice_count": @"11"},
                            @{@"themes_image": @"将抖腿进行到底",
                              @"title": @"【3D】将抖腿进行到底",
                              @"voice_count": @"24"},
                            @{@"themes_image": @"小提琴&钢琴",
                              @"title": @"【珠帘合璧】小提琴&钢琴，这该是天然缠绵出美好的一对",
                              @"voice_count": @"9"},
                            @{@"themes_image": @"vocaliod+",
                              @"title": @"【高能（中毒）向】Vocaliod+电音remix",
                              @"voice_count": @"14"}];
    
    self.voiceListTitle = @[@{@"title": @"古风",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"作业向",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"治愈",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"热血",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"翻唱",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"催眠",
                              @"image": @"new_line_soundlist_3x12_"}];
}

- (void)dataSourceOfClassify
{
//    self.classiftPic = [[NSArray alloc] initWithObjects:@"http://static.missevan.com/app/46.png",
//                        @"http://static.missevan.com/app/8.png",
//                        @"http://static.missevan.com/app/26.png",
//                        @"http://static.missevan.com/app/54.png",
//                        @"http://static.missevan.com/app/5.png",
//                        @"http://static.missevan.com/app/41.png",
//                        @"http://static.missevan.com/app/6.png",
//                        @"http://static.missevan.com/app/4.png",
//                        @"http://static.missevan.com/app/13.png",
//                        @"http://static.missevan.com/app/52.png",
//                        @"http://static.missevan.com/app/55.png",
//                        @"http://static.missevan.com/app/65.png", nil];
//    
//    self.classiftTitle = [[NSArray alloc] initWithObjects:@"有声漫画", @"音乐", @"娱乐", @"催眠", @"广播剧", @"日抓", @"听书", @"电台", @"声优库", @"配音", @"游戏", @"铃声", nil];
    self.classiftPic = @[@{@"image":@"http://static.missevan.com/app/46.png", @"title":@"有声漫画"},
                         @{@"image":@"http://static.missevan.com/app/8.png", @"title":@"音乐"},
                         @{@"image":@"http://static.missevan.com/app/26.png", @"title":@"娱乐"},
                         @{@"image":@"http://static.missevan.com/app/54.png", @"title":@"催眠"},
                         @{@"image":@"http://static.missevan.com/app/5.png", @"title":@"广播剧"},
                         @{@"image":@"http://static.missevan.com/app/41.png", @"title":@"日抓"},
                         @{@"image":@"http://static.missevan.com/app/6.png", @"title":@"听书"},
                         @{@"image":@"http://static.missevan.com/app/4.png", @"title":@"电台"},
                         @{@"image":@"http://static.missevan.com/app/13.png", @"title":@"声优库"},
                         @{@"image":@"http://static.missevan.com/app/52.png", @"title":@"配音"},
                         @{@"image":@"http://static.missevan.com/app/55.png", @"title":@"游戏"},
                         @{@"image":@"http://static.missevan.com/app/65.png", @"title":@"铃声"},];
    
    self.classiftNightPic = @[@{@"image":@"http://static.missevan.com/app/dark/46.png", @"title":@"有声漫画"},
                         @{@"image":@"http://static.missevan.com/app/dark/8.png", @"title":@"音乐"},
                         @{@"image":@"http://static.missevan.com/app/dark/26.png", @"title":@"娱乐"},
                         @{@"image":@"http://static.missevan.com/app/dark/54.png", @"title":@"催眠"},
                         @{@"image":@"http://static.missevan.com/app/dark/5.png", @"title":@"广播剧"},
                         @{@"image":@"http://static.missevan.com/app/dark/41.png", @"title":@"日抓"},
                         @{@"image":@"http://static.missevan.com/app/dark/6.png", @"title":@"听书"},
                         @{@"image":@"http://static.missevan.com/app/dark/4.png", @"title":@"电台"},
                         @{@"image":@"http://static.missevan.com/app/dark/13.png", @"title":@"声优库"},
                         @{@"image":@"http://static.missevan.com/app/dark/52.png", @"title":@"配音"},
                         @{@"image":@"http://static.missevan.com/app/dark/55.png", @"title":@"游戏"},
                         @{@"image":@"http://static.missevan.com/app/dark/65.png", @"title":@"铃声"},];
}

- (void)dataSourceOfMy
{
//    self.myIconArray = @[@[@{@"image":@"m_icon_history_45x45_", @"title":@"历史记录"},
//                           @{@"image":@"m_icon_bell_45x45_", @"title":@"铃声设置"},
//                           @{@"image":@"m_icon_collect_45x45_", @"title":@"我的收藏"},
//                           @{@"image":@"m_icon_attention_45x45_", @"title":@"我的关注"},
//                           @{@"image":@"m_icon_download_45x45_", @"title":@"本地下载"},
//                           @{@"image":@"m_icon_mission_45x45_", @"title":@"每日任务"},
//                           @{@"image":@"m_icon_timer_45x45_", @"title":@"定时关闭"},
//                           @{@"image":@"m_icon_feedback_45x45_", @"title":@"意见反馈"}],
//                         @[@{@"image":@"m_icon_comment_45x45_", @"title":@"我的评论"},
//                           @{@"image":@"m_icon_message_45x45_", @"title":@"我的私信"}]];
    
    //v3.7.0 -
    self.myIconArray = @[@[@{@"image":@"m_icon_history_45x45_", @"title":@"历史记录"},
                           @{@"image":@"m_icon_collect_45x45_", @"title":@"我的收藏"},
                           @{@"image":@"m_icon_attention_45x45_", @"title":@"我的关注"},
                           @{@"image":@"m_icon_download_45x45_", @"title":@"本地下载"},
                           @{@"image":@"m_icon_mission_45x45_", @"title":@"每日任务"},
                           @{@"image":@"m_icon_timer_45x45_", @"title":@"定时关闭"},
                           @{@"image":@"m_icon_feedback_45x45_", @"title":@"意见反馈"},
                           @{@"image":@"m_icon_theme_45x45_", @"title":@"主题切换"}],
                         @[@{@"image":@"m_icon_comment_45x45_", @"title":@"我的评论"},
                           @{@"image":@"m_icon_message_45x45_", @"title":@"我的私信"}]];
    
    self.myNightIconArray = @[@[@{@"image":@"m_icon_history_night_45x45_", @"title":@"历史记录"},
                           @{@"image":@"m_icon_collect_night_45x45_", @"title":@"我的收藏"},
                           @{@"image":@"m_icon_attention_night_45x45_", @"title":@"我的关注"},
                           @{@"image":@"m_icon_download_night_45x45_", @"title":@"本地下载"},
                           @{@"image":@"m_icon_mission_night_45x45_", @"title":@"每日任务"},
                           @{@"image":@"m_icon_timer_night_45x45_", @"title":@"定时关闭"},
                           @{@"image":@"m_icon_feedback_night_45x45_", @"title":@"意见反馈"},
                           @{@"image":@"m_icon_theme_night_45x45_", @"title":@"主题切换"}],
                         @[@{@"image":@"m_icon_comment_night_45x45_", @"title":@"我的评论"},
                           @{@"image":@"m_icon_message_night_45x45_", @"title":@"我的私信"}]];
}

- (void)dataSourceOfOther
{
    self.pmIconArray = @[@"pm_timer_36x36_", @"danmakuSet_36x36_", @"pm_collection_36x36_", @"pm_fish_36x36_", @"pm_bell_36x36_"];
    
    self.pmNightIconArray = @[@"pm_timer_night_36x36_", @"pm_danmaku_setting_night_36x36_", @"pm_collection_night_36x36_", @"pm_fish_night_36x36_", @"pm_bell_night_36x36_"];
    
    self.danmakuOptionsArray = @[@{@"image":@"new_share_play_23x20_", @"title":@"分 享"},
                                 @{@"image":@"like2Nor_27x23_", @"title":@"喜 欢"},
                                 @{@"image":@"new_down_25x24_", @"title":@"下 载"},
                                 @{@"image":@"new_feed_w_30x20_", @"title":@"投 食"}];

    self.danmakuOptionsNightArray = @[@{@"image":@"new_share_play_n_23x20_", @"title":@"分 享"},
                                      @{@"image":@"new_like_n_27x23_", @"title":@"喜 欢"},
                                      @{@"image":@"new_down_n_25x24_", @"title":@"下 载"},
                                      @{@"image":@"new_feed_n_30x20_", @"title":@"投 食"}];
    
    self.audioIntroductionDic = @{@"introduction":@"-\u4e16\u672b\u6b4c\u8005--   \u66f2\u8bcd\u7f16\u8c03\uff1aCOP \u6f14\u5531\uff1a\u5c11\u5e74\u971c\u00a0 \u540e\u671f\uff1a\u51cc\u4e71\u65b0\u6674   \u8749\u65f6\u96e8 \u5316\u6210\u6de1\u58a8\u6e32\u67d3\u66ae\u8272 \u6e17\u900f\u7740 \u52fe\u52d2\u51fa\u8db3\u8ff9\u4e0e\u8f66\u8f99 \u6b22\u7b11\u58f0 \u4e0e\u6f02\u6d6e\u7684\u6c34\u6c7d\u9971\u548c \u9694\u7740\u7a97 \u540c\u57ce\u5e02\u4e00\u5e76\u6a21\u7cca\u4e86   \u62e8\u5f04\u7740 \u65e7\u5409\u4ed6 \u54fc\u7740\u56db\u62cd\u5b50\u7684\u6b4c \u56de\u97f3\u4e2d \u4e00\u4e2a\u4eba \u4eff\u4f5b\u9887\u60a0\u7136\u81ea\u5f97 \u7b49\u51c9\u96e8 \u7684\u6e29\u5ea6 \u5c06\u4e0d\u5b89\u71e5\u70ed\u4e2d\u548c \u5bfb\u89c5\u7740 \u98ce\u7684\u6ce2\u6298   \u6211\u4ecd\u7136\u5728 \u65e0\u4eba\u95ee\u6d25\u7684\u9634\u96e8\u9709\u6e7f\u4e4b\u5730 \u548c\u7740\u96e8\u97f3 \u5531\u7740\u6ca1\u6709\u542c\u4f17\u7684\u6b4c\u66f2 \u4eba\u6f6e\u4ecd\u662f \u6f2b\u65e0\u76ee\u7684\u5730\u5411\u76ee\u7684\u5730\u6563\u53bb \u5fd9\u788c\u7740 \u65e0\u4e3a\u7740 \u7ee7\u7eed   \u7b49\u5f85\u7740\u8c01\u80fd\u591f\u5c06\u6211\u7684\u5fc3\u623f\u8f7b\u8f7b\u53e9\u51fb \u5373\u4f7f\u662f\u4f60 \u4e5f\u4ec5\u4ec5\u9a7b\u8db3\u4e86\u7247\u523b\u4fbf\u79bb\u53bb \u60f3\u7740\u6216\u8bb8 \u4e0b\u4e2a\u8def\u53e3\u4f1a\u6709\u8c01\u4e0e\u6211\u76f8\u9047 \u54ea\u6015\u53ea \u4e00\u77ac\u7684 \u5947\u8ff9     \u590f\u591c\u7a7a \u51fa\u73b0\u5728\u9065\u8fdc\u7684\u7684\u8bb0\u5fc6 \u7efd\u653e\u7684 \u7480\u74a8\u82b1\u706b \u62e5\u7740\u7e41\u661f \u6d88\u5931\u524d \u505a\u51fa\u6700\u6e29\u67d4\u7684\u7ed9\u4e88 \u4e00\u5982\u90a3\u4e9b\u6a21\u7cca\u8eab\u5f71\u7684\u522b\u79bb   \u56f0\u60d1\u5730 \u62d8\u675f\u7740 \u5982\u57ce\u5e02\u6c60\u4e2d\u4e4b\u9c7c \u6216\u54fd\u54bd \u6216\u4f4e\u6ce3 \u90fd\u878d\u8fdb\u4e86\u6ce1\u6cab\u91cc \u62d6\u66f3\u75b2\u60eb\u8eab\u8eaf \u6c89\u5165\u51b0\u51b7\u7684\u6c60\u5e95 \u6ce8\u89c6\u7740 \u8272\u5f69\u892a\u53bb   \u6211\u4ecd\u7136\u5728\u65e0\u4eba\u95ee\u6d25\u7684\u9634\u96e8\u9709\u6e7f\u4e4b\u5730 \u548c\u7740\u96e8\u97f3 \u5531\u7740\u6ca1\u6709\u542c\u4f17\u7684\u6b4c\u66f2 \u4eba\u6f6e\u4ecd\u662f\u6f2b\u65e0\u76ee\u7684\u5730\u5411\u76ee\u7684\u5730\u6563\u53bb \u5fd9\u788c\u7740 \u65e0\u4e3a\u7740 \u7ee7\u7eed   \u7b49\u5f85\u7740\u8c01\u80fd\u591f\u5c06\u6211\u7684\u5fc3\u623f\u8f7b\u8f7b\u53e9\u51fb \u5373\u4f7f\u662f\u4f60 \u4e5f\u4ec5\u4ec5\u9a7b\u8db3\u4e86\u7247\u523b\u4fbf\u79bb\u53bb \u60f3\u7740\u6216\u8bb8 \u4e0b\u4e2a\u8def\u53e3\u4f1a\u6709\u8c01\u4e0e\u6211\u76f8\u9047 \u54ea\u6015\u53ea \u4e00\u77ac\u7684 \u5947\u8ff9   \u6781\u591c\u4e0e\u6c38\u663c \u522b\u79bb\u4e0e\u6b22\u805a \u8109\u640f\u4e0e\u547c\u5438 \u627e\u5bfb\u7740\u610f\u4e49   \u6211\u4ecd\u7136\u5728\u65e0\u4eba\u95ee\u6d25\u7684\u9634\u96e8\u9709\u6e7f\u4e4b\u5730 \u548c\u7740\u96e8\u97f3 \u5531\u7740\u5356\u4e0d\u51fa\u53bb\u7684\u6b4c\u66f2 \u6d6e\u6e38\u4e4b\u4eba\u4e5f\u6323\u624e\u4e0d\u5df2\u6267\u7740\u5b58\u5728\u4e0b\u53bb \u8ffd\u9010\u7740 \u68a6\u60f3\u7740 \u7ee7\u7eed   \u8bf7\u522b\u8ba9\u6211\u72ec\u81ea\u530d\u5310\u4e8e\u6ec2\u6cb1\u4e16\u672b\u4e4b\u96e8 \u548c\u7740\u96e8\u97f3 \u5531\u7740\u89c1\u8bc1\u7ec8\u7ed3\u7684\u6b4c\u66f2 \u4eba\u4eec\u7ec8\u4e8e \u7ed3\u675f\u4e86\u5bfb\u89c5\u5446\u6ede\u4f2b\u7acb\u539f\u5730 \u54ed\u6ce3\u7740 \u4e5e\u6c42\u7740 \u5947\u8ff9   \u7528\u8fd9\u53cc\u624b \u62e8\u51fa\u6b8b\u7f3a\u67d3\u4e86\u9508\u8ff9\u7684\u5f26\u97f3 \u90fd\u9690\u6ca1\u4e8e \u6dcb\u6f13\u7684\u96e8\u5e55\u65e0\u58f0\u65e0\u606f \u66f2\u7ec8\u4e4b\u65f6 \u4f60\u662f\u5426\u4fbf\u4f1a\u56de\u5e94\u6211\u7684\u5fc3\u97f3 \u5c06\u98a4\u6296\u7684\u53cc\u624b\u7275\u8d77 \u8fce\u6765\u6bcf\u4e2a\u4eba\u7684\u7ed3\u5c40   "};
    
    self.VoiceListOfContainsArray = @[@{@"themes_image": @"http://static.missevan.com/coversmini/201611/22/eca2abfc1035abeea9d8d963acca7ef0124902.jpg",
                                        @"title": @"\u5361\u7f07",
                                        @"voice_count": @"69"},
                                      @{@"themes_image": @"http://static.missevan.com/coversmini/201511/21/c4bdc3300e89ecf7282aae7e2975ebf2123054.jpg",
                                        @"title": @"\u51a5\u5929\u5929\u7684\u767e\u5b9d\u7bb1",
                                        @"voice_count": @"106"},
                                      @{@"themes_image": @"http://static.missevan.com/coversmini/201512/20/a8fc49e0146d1682ec8aed95b22a0b0e120450.jpg",
                                                                  @"title": @"\u5176\u4ed6(\u53ea\u662f\u4e3a\u4e86\u65b9\u4fbf\u7f62\u4e86)",
                                                                  @"voice_count": @"50"}];
    
    self.likeAudioArray = @[@{@"themes_image": @"http://static.missevan.com/coversmini/201410/06/107b571eca6d756f4f9cabab80114803001229.jpg",
                              @"title": @"\u3010\u897f\u74dcKune\u3011\u864e\u8996\u7708\u3005",
                              @"played_count": @"25921",
                              @"words_count": @"459"},
                            @{@"themes_image": @"http://static.missevan.com/coversmini/201410/23/c098b54aa8048b0ebc0b49adf691281c202854.jpg",
                              @"title": @"Unravel\u3010\u661f\u4e4b\u58f0\u7ffb\u914d\u300a\u4e1c\u4eac\u98df\u5c38\u9b3c\u300b\u4e2d\u6587OP\u3011",
                              @"played_count": @"37945",
                              @"words_count": @"671"},
                            @{@"themes_image": @"http://static.missevan.com/coversmini/201501/29/1989fb4199506192b38e9c271167fda3221038.jpeg",
                              @"title": @"\u3010\u6ce0\u9e22\u3011unravel-\u4e1c\u4eac\u98df\u5c38\u9b3c-Dj-Jo Remix ver",
                              @"played_count": @"27554",
                              @"words_count": @"1091"}];
}
@end
