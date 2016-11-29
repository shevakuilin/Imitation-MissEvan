//
//  MESearchHistoryTableViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/29.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MESearchHistoryTableViewCell.h"
#import "MEHeader.h"

@implementation MESearchHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (self) {
            self.backgroundColor = ME_Color(243, 243, 243);
            
            UIImageView * historyIcon = [UIImageView new];
            [self addSubview:historyIcon];
            historyIcon.image = [UIImage imageNamed:@"hp_history_17x17_"];
            [historyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(10);
                make.centerY.equalTo(self).with.offset(0);
            }];
            
            UILabel * historyWordsLabel = [UILabel new];
            [self addSubview:historyWordsLabel];
            historyWordsLabel.font = [UIFont systemFontOfSize:13];
            historyWordsLabel.text = @"平川大辅";
            [historyWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(historyIcon.mas_right).with.offset(10);
                make.centerY.equalTo(self).with.offset(0);
            }];
            
            UIButton * deleteButton = [UIButton new];
            [self addSubview:deleteButton];
            [deleteButton setImage:[UIImage imageNamed:@"hp_delete_11x10_"] forState:UIControlStateNormal];
            [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).with.offset(-16);
                make.centerY.equalTo(self).with.offset(0);
            }];
        }
    }
    return self;
}

@end
