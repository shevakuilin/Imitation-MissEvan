//
//  MEHomeRecommendTopTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/7.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeRecommendTopTableViewCell.h"
#import "MEHeader.h"

@implementation MEHomeRecommendTopTableViewCell


- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor whiteColor];
    //draw - views
    UIView * view1 = [UIView new];
    [self addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.bottom.equalTo(self).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
    }];
    
    UIView * view2 = [UIView new];
    [self addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(ME_Width / 4);
        make.bottom.equalTo(self).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
    }];
    
    UIView * view3 = [UIView new];
    [self addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset((ME_Width / 4) * 2);
        make.bottom.equalTo(self).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
    }];
    
    UIView * view4 = [UIView new];
    [self addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset((ME_Width / 4) * 3);
        make.bottom.equalTo(self).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
    }];
    
    //draw - others
    self.imageView1 = [UIImageView new];
    [view1 addSubview:self.imageView1];
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1).with.offset(0);
        make.left.equalTo(view1).with.offset(0);
        make.right.equalTo(view1).with.offset(0);
        make.bottom.equalTo(view1).with.offset(-25);

    }];

    self.imageView2 = [UIImageView new];
    [view2 addSubview:self.imageView2];
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2).with.offset(0);
        make.left.equalTo(view2).with.offset(0);
        make.right.equalTo(view2).with.offset(0);
        make.bottom.equalTo(view2).with.offset(-25);

    }];
    
    self.imageView3 = [UIImageView new];
    [view3 addSubview:self.imageView3];
    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3).with.offset(0);
        make.left.equalTo(view3).with.offset(0);
        make.right.equalTo(view3).with.offset(0);
        make.bottom.equalTo(view3).with.offset(-25);

    }];
    
    self.imageView4 = [UIImageView new];
    [view4 addSubview:self.imageView4];
    [self.imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4).with.offset(0);
        make.left.equalTo(view4).with.offset(0);
        make.right.equalTo(view4).with.offset(0);
        make.bottom.equalTo(view4).with.offset(-25);

    }];

    
    self.label1 = [UILabel new];
    [view1 addSubview:self.label1];
    self.label1.text = @"活动";
    self.label1.textAlignment = NSTextAlignmentCenter;
    self.label1.font = [UIFont systemFontOfSize:14];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1).with.offset(35);
        make.left.equalTo(view1).with.offset(0);
        make.right.equalTo(view1).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 15));
    }];
    
    self.label2 = [UILabel new];
    [view2 addSubview:self.label2];
    self.label2.text = @"排行";
    self.label2.textAlignment = NSTextAlignmentCenter;
    self.label2.font = [UIFont systemFontOfSize:14];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2).with.offset(35);
        make.left.equalTo(view2).with.offset(0);
        make.right.equalTo(view2).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 15));
    }];

    self.label3 = [UILabel new];
    [view3 addSubview:self.label3];
    self.label3.text = @"广播剧";
    self.label3.textAlignment = NSTextAlignmentCenter;
    self.label3.font = [UIFont systemFontOfSize:14];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3).with.offset(35);
        make.left.equalTo(view3).with.offset(0);
        make.right.equalTo(view3).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 15));
    }];

    self.label4 = [UILabel new];
    [view4 addSubview:self.label4];
    self.label4.text = @"任务";
    self.label4.textAlignment = NSTextAlignmentCenter;
    self.label4.font = [UIFont systemFontOfSize:14];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4).with.offset(35);
        make.left.equalTo(view4).with.offset(0);
        make.right.equalTo(view4).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 15));
    }];
    
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
}

@end
