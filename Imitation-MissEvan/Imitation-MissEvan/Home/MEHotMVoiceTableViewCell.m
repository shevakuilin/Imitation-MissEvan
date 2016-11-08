//
//  MEHotMVoiceTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/8.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHotMVoiceTableViewCell.h"
#import "MEHeader.h"

@implementation MEHotMVoiceTableViewCell

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
        self.backgroundColor = [UIColor whiteColor];
        
        
        
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
