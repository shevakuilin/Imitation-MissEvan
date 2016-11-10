//
//  MEChannelTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/9.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEChannelTableViewCell.h"
#import "MEHeader.h"

@implementation MEChannelTableViewCell

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
        self.leftView = [UIView new];
        [self addSubview:self.leftView];
        self.leftView.backgroundColor = [UIColor yellowColor];
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 2, 174));
        }];
        
        self.rightView = [UIView new];
        [self addSubview:self.rightView];
        self.rightView.backgroundColor = [UIColor grayColor];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 2, 174));
        }];
        
        
        
        
        self.downShadow = [UIImageView new];
        [self addSubview:self.downShadow];
        self.downShadow.backgroundColor = ME_Color(238, 238, 238);//229, 230, 230
        [self.downShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
        }];
    }
    return self;
}

@end
