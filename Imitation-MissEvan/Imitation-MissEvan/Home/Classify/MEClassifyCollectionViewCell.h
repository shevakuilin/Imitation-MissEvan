//
//  MEClassifyCollectionViewCell.h
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/16.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEClassifyCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * classifyImageView;
@property (nonatomic, strong) UILabel * classifyLabel;

@property (nonatomic, strong) NSString * picUrl;
@property (nonatomic, strong) NSString * title;
@end
