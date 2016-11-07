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
    self.view1 = [UIView new];
    [self addSubview:self.view1];
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.bottom.equalTo(self).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
    }];
    
    self.view2 = [UIView new];
    [self addSubview:self.view2];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(ME_Width / 4);
        make.bottom.equalTo(self).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
    }];
    
    self.view3 = [UIView new];
    [self addSubview:self.view3];
    [self.view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset((ME_Width / 4) * 2);
        make.bottom.equalTo(self).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
    }];
    
    self.view4 = [UIView new];
    [self addSubview:self.view4];
    [self.view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset((ME_Width / 4) * 3);
        make.bottom.equalTo(self).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
    }];
    
    //draw - others
    self.imageView1 = [UIImageView new];
    [self.view1 addSubview:self.imageView1];
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view1).with.offset(0);
        make.centerX.equalTo(self.view1).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));

    }];

    self.imageView2 = [UIImageView new];
    [self.view2 addSubview:self.imageView2];
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view2).with.offset(0);
        make.centerX.equalTo(self.view2).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    self.imageView3 = [UIImageView new];
    [self.view3 addSubview:self.imageView3];
    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view3).with.offset(0);
        make.centerX.equalTo(self.view3).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    self.imageView4 = [UIImageView new];
    [self.view4 addSubview:self.imageView4];
    [self.imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view4).with.offset(0);
        make.centerX.equalTo(self.view4).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    
    self.label1 = [UILabel new];
    [self.view1 addSubview:self.label1];
    self.label1.textAlignment = NSTextAlignmentCenter;
    self.label1.font = [UIFont systemFontOfSize:13];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view1).with.offset(40);
        make.left.equalTo(self.view1).with.offset(0);
        make.right.equalTo(self.view1).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 15));
    }];
    
    self.label2 = [UILabel new];
    [self.view2 addSubview:self.label2];
    self.label2.textAlignment = NSTextAlignmentCenter;
    self.label2.font = [UIFont systemFontOfSize:13];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view2).with.offset(40);
        make.left.equalTo(self.view2).with.offset(0);
        make.right.equalTo(self.view2).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 15));
    }];

    self.label3 = [UILabel new];
    [self.view3 addSubview:self.label3];
    self.label3.textAlignment = NSTextAlignmentCenter;
    self.label3.font = [UIFont systemFontOfSize:13];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view3).with.offset(40);
        make.left.equalTo(self.view3).with.offset(0);
        make.right.equalTo(self.view3).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 15));
    }];

    self.label4 = [UILabel new];
    [self.view4 addSubview:self.label4];
    self.label4.textAlignment = NSTextAlignmentCenter;
    self.label4.font = [UIFont systemFontOfSize:13];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view4).with.offset(40);
        make.left.equalTo(self.view4).with.offset(0);
        make.right.equalTo(self.view4).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 15));
    }];
    
    self.imageView1.image = [UIImage imageNamed:self.dic[@"activity"]];
    self.imageView2.image = [UIImage imageNamed:self.dic[@"rank"]];
    self.imageView3.image = [UIImage imageNamed:self.dic[@"channel"]];
    self.imageView4.image = [UIImage imageNamed:self.dic[@"mission"]];
    
    self.label1.text = self.dic[@"activity_title"];
    self.label2.text = self.dic[@"rank_title"];
    self.label3.text = self.dic[@"channel_title"];
    self.label4.text = self.dic[@"mission_title"];
    
}

//- (void)setLabel1:(UILabel *)label1
//{
//    _label1 = label1;
//    label1.text = self.dic[@"activity_title"];
//}
//
//- (void)setDic:(NSDictionary *)dic
//{
//    _dic = dic;
//    self.imageView1.image = [UIImage imageNamed:dic[@"activity"]];
//    self.imageView2.image = [UIImage imageNamed:dic[@"rank"]];
//    self.imageView3.image = [UIImage imageNamed:dic[@"channel"]];
//    self.imageView4.image = [UIImage imageNamed:dic[@"mission"]];
//    
//    self.label1.text = dic[@"activity_title"];
//    self.label2.text = dic[@"rank_title"];
//    self.label3.text = dic[@"channel_title"];
//    self.label4.text = dic[@"mission_title"];
//}


@end
