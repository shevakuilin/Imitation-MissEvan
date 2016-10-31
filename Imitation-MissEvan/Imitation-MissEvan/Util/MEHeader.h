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

#define ME_DATASOURCE   [MEDataSource shareDataSource]

#define ME_Color(x, y, z)   [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1]

#define ME_ViewController(vcID, sbName) [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcID]

#define ME_Width    [UIScreen mainScreen].bounds.size.width

#define ME_Height   [UIScreen mainScreen].bounds.size.height

#endif /* MEHeader_h */
