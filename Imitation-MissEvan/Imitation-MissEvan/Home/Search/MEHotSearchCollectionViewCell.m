//
//  MEHotSearchCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/29.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHotSearchCollectionViewCell.h"
#import "MEHeader.h"

@interface MEHotSearchCollectionViewCell ()
@property (nonatomic, strong) UILabel * hotWordsLabel;

@end

@implementation MEHotSearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = ME_Color(243, 243, 243);
            
            self.hotWordsLabel = [UILabel new];
            [self addSubview:self.hotWordsLabel];
            self.hotWordsLabel.font = [UIFont systemFontOfSize:12];
            self.hotWordsLabel.textColor = ME_Color(189, 189, 189);
            self.hotWordsLabel.textAlignment = NSTextAlignmentCenter;
            self.hotWordsLabel.backgroundColor = [UIColor whiteColor];
            self.hotWordsLabel.layer.masksToBounds = YES;
            self.hotWordsLabel.layer.cornerRadius = 12;
            self.hotWordsLabel.layer.borderColor = [UIColor grayColor].CGColor;
            self.hotWordsLabel.layer.borderWidth = 0.5;
            [self.hotWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self).with.offset(0);
    
            }];
        }
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.hotWordsLabel.text = [NSString stringWithFormat:@"%@", dic[@"hotwords"]];
    
    [self.hotWordsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.hotWordsLabel.text.length * 12, 25));
        make.left.equalTo(self).with.offset(1);
        make.right.equalTo(self).with.offset(-1);
    }];
}

@end
