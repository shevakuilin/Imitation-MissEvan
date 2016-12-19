//
//  MEMyPersonalCenterTableViewCell.h
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/30.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEMyPersonalCenterTableViewCell;

@protocol ClassViewCellDelegate <NSObject>

- (void)classViewCell:(MEMyPersonalCenterTableViewCell *)cell didSelectWithItem:(id)item;

@end

@interface MEMyPersonalCenterTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray * array;
@property (weak, nonatomic) id<ClassViewCellDelegate> delegate;

@end
