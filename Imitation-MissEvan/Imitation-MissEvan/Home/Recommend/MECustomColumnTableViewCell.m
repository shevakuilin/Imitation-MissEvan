//
//  MECustomColumnTableViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/13.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MECustomColumnTableViewCell.h"
#import "MEHeader.h"

@interface MECustomColumnTableViewCell ()
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation MECustomColumnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = ME_Color(250, 250, 250);
        
        self.titleLabel = [UILabel new];
        [self addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textColor = ME_Color(136, 136, 136);
        self.titleLabel.text = @"现在可以根据个人喜好，自由添加并调整栏目顺序啦+_+";
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(10);
            make.centerX.equalTo(self).with.offset(5);
            
//            make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, 14));
            
        }];
        
        self.customButton = [UIButton new];
        [self addSubview:self.customButton];
        [self.customButton setTitle:@"自定义栏目" forState:UIControlStateNormal];
        [self.customButton setTitleColor:ME_Color(226, 59, 59) forState:UIControlStateNormal];
        self.customButton.titleLabel.font = [UIFont systemFontOfSize:12];
        self.customButton.layer.masksToBounds = YES;
        self.customButton.layer.cornerRadius = 5;
        self.customButton.layer.borderColor = ME_Color(226, 59, 59).CGColor;
        self.customButton.layer.borderWidth = 1;
        [self.customButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(8);
            make.centerX.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 30));
        }];
    }
    return self;
}

@end
