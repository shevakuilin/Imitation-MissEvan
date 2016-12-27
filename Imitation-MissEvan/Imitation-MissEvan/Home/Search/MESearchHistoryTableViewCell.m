//
//  MESearchHistoryTableViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/29.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MESearchHistoryTableViewCell.h"
#import "MEHeader.h"

@interface MESearchHistoryTableViewCell ()
@property (nonatomic, strong) UILabel * historyWordsLabel;
@end

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
            self.backgroundColor = [UIColor clearColor];//ME_Color(243, 243, 243);
            
            UIImageView * historyIcon = [UIImageView new];
            [self addSubview:historyIcon];
            historyIcon.image = [UIImage imageNamed:@"hp_history_17x17_"];
            [historyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(10);
                make.centerY.equalTo(self).with.offset(0);
            }];
            
            self.historyWordsLabel = [UILabel new];
            [self addSubview:self.historyWordsLabel];
            self.historyWordsLabel.font = [UIFont systemFontOfSize:13];
            [self.historyWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(historyIcon.mas_right).with.offset(10);
                make.centerY.equalTo(self).with.offset(0);
            }];
            
            UIButton * deleteButton = [UIButton new];
            [self addSubview:deleteButton];
            [deleteButton setImage:[UIImage imageNamed:@"hp_delete_11x10_"] forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
            [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).with.offset(-16);
                make.centerY.equalTo(self).with.offset(0);
            }];
        }
    }
    return self;
}

- (void)delete
{
    //TODO:删除该条记录
    if ([self.delegate respondsToSelector:@selector(deleteTheHistoryWords:)]) {
        [self.delegate deleteTheHistoryWords:self];
    }
}

- (void)setSearchWords:(NSString *)searchWords
{
    _searchWords = searchWords;
    self.historyWordsLabel.text = searchWords;
}

@end
