//
//  MEVoiceListTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/11.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEVoiceListTableViewCell.h"
#import "MEHeader.h"

@interface MEVoiceListTableViewCell ()
@property (nonatomic, strong) UIImageView * leftAlbumShadowImageView;
@property (nonatomic, strong) UIImageView * centerAlbumShadowImageView;
@property (nonatomic, strong) UIImageView * rightAlbumShadowImageView;

@end

@implementation MEVoiceListTableViewCell

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
        
    }
    return self;
}

@end
