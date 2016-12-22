//
//  MEVoiceListTableViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/11.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEBaseMoreTableViewCell.h"
@interface MEVoiceListTableViewCell : MEBaseMoreTableViewCell
@property (strong, nonatomic) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray * array;
@end
