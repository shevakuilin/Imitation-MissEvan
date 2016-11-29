//
//  MEHeader.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/31.
//  Copyright © 2016年 xkl. All rights reserved.
//

#ifndef MEHeader_h
#define MEHeader_h

#import "MEDataSource.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+GIF.h"
#import "iCarousel.h"
#import "MEUtil.h"
#import "MEPageControl+AutoScroll.h"
#import "MEScaleToSize.h"
#import "UIImageView+AFNetworking.h"
#import "UICollectionViewLeftAlignedLayout.h"

#define ME_DATASOURCE   [MEDataSource shareDataSource]

#define ME_Color(x, y, z)   [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1]

#define ME_ViewController(vcID, sbName) [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcID]

#define ME_Width    [UIScreen mainScreen].bounds.size.width

#define ME_Height   [UIScreen mainScreen].bounds.size.height

#define ME_GetViewController(vcID, sbName) [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcID]

#ifdef DEBUG
#   define MELog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define MELog(...)
#endif

//网络宏定义
#define ME_URL_GLOBAL  @"http://static.missevan.com/"
#define ME_URL_SOUND   @"sound/"
#define ME_URL_IMAGE   @"mimages/"
#define ME_SOUND_MIAO  @"201607/05/8541a2c408b8cda2ff671ef35c27e8e7134938"
#define ME_IMAGE_START  @"201610/26/bf12252c78f3930b62cb71b2583b7bfb170900"
//http://static.missevan.com/sound/201607/05/8541a2c408b8cda2ff671ef35c27e8e7134938.mp3;  //喵音
//http://static.missevan.com/mimages/201610/26/bf12252c78f3930b62cb71b2583b7bfb170900.png //启动图


/*
 ** MEHomeSegment
 */
#define Default_Line_Height      2
#define Default_Color           [UIColor grayColor]
#define Default_Highlight_Color [UIColor blackColor]
#define Default_Title_font      [UIFont systemFontOfSize:15]
#define Item_Padding     20
#define DefaultSegmentHeight 40

#endif /* MEHeader_h */
