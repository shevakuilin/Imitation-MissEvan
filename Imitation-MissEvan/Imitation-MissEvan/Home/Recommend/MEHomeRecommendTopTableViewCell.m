//
//  MEHomeRecommendTopTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/7.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeRecommendTopTableViewCell.h"
#import "MEHeader.h"
#import "MEHomeRecommendTopCollectionViewCell.h"

@interface MEHomeRecommendTopTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView * collectionView;

@end;
@implementation MEHomeRecommendTopTableViewCell

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
        
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //创建collectionView 通过一个布局策略layout来创建
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        [self addSubview:self.collectionView];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
        }];
        [self.collectionView registerClass:[MEHomeRecommendTopCollectionViewCell class] forCellWithReuseIdentifier:@"HomeRecommendTop"];
        //draw - views
//        self.leftView = [UIView new];
//        [self addSubview:self.leftView];
//        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).with.offset(0);
//            make.left.equalTo(self).with.offset(0);
//            make.bottom.equalTo(self).with.offset(0);
//            
//            make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
//        }];
//        
//        self.centLeftView = [UIView new];
//        [self addSubview:self.centLeftView];
//        [self.centLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).with.offset(0);
//            make.left.equalTo(self).with.offset(ME_Width / 4);
//            make.bottom.equalTo(self).with.offset(0);
//            
//            make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
//        }];
//        
//        self.centRightView = [UIView new];
//        [self addSubview:self.centRightView];
//        [self.centRightView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).with.offset(0);
//            make.left.equalTo(self).with.offset((ME_Width / 4) * 2);
//            make.bottom.equalTo(self).with.offset(0);
//            
//            make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
//        }];
//        
//        self.rightView = [UIView new];
//        [self addSubview:self.rightView];
//        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).with.offset(0);
//            make.left.equalTo(self).with.offset((ME_Width / 4) * 3);
//            make.bottom.equalTo(self).with.offset(0);
//            
//            make.size.mas_equalTo(CGSizeMake(ME_Width / 4, self.bounds.size.height));
//        }];
//        
//        //draw - others
//        self.leftImageView = [UIImageView new];
//        [self.leftView addSubview:self.leftImageView];
//        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.leftView).with.offset(4);
//            make.centerX.equalTo(self.leftView).with.offset(0);
//
//            
//        }];
//        
//        self.centLeftImageView = [UIImageView new];
//        [self.centLeftView addSubview:self.centLeftImageView];
//        [self.centLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.centLeftView).with.offset(4);
//            make.centerX.equalTo(self.centLeftView).with.offset(0);
//
//        }];
//        
//        self.centRightImageView = [UIImageView new];
//        [self.centRightView addSubview:self.centRightImageView];
//        [self.centRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.centRightView).with.offset(4);
//            make.centerX.equalTo(self.centRightView).with.offset(0);
//
//        }];
//        
//        self.rightImageView = [UIImageView new];
//        [self.rightView addSubview:self.rightImageView];
//        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.rightView).with.offset(4);
//            make.centerX.equalTo(self.rightView).with.offset(0);
//
//        }];
//        
//        
//        self.leftLabel = [UILabel new];
//        [self.leftView addSubview:self.leftLabel];
//        self.leftLabel.textAlignment = NSTextAlignmentCenter;
//        self.leftLabel.font = [UIFont systemFontOfSize:13];
//        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.leftImageView.mas_bottom).with.offset(1);
//            make.centerX.equalTo(self.leftImageView).with.offset(0);
//
//        }];
//        
//        self.centLeftLabel = [UILabel new];
//        [self.centLeftView addSubview:self.centLeftLabel];
//        self.centLeftLabel.textAlignment = NSTextAlignmentCenter;
//        self.centLeftLabel.font = [UIFont systemFontOfSize:13];
//        [self.centLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.centLeftImageView.mas_bottom).with.offset(1);
//            make.centerX.equalTo(self.centLeftImageView).with.offset(0);
//
//        }];
//        
//        self.centRightLabel = [UILabel new];
//        [self.centRightView addSubview:self.centRightLabel];
//        self.centRightLabel.textAlignment = NSTextAlignmentCenter;
//        self.centRightLabel.font = [UIFont systemFontOfSize:13];
//        [self.centRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.centRightImageView.mas_bottom).with.offset(1);
//            make.centerX.equalTo(self.centRightImageView).with.offset(0);
//
//        }];
//        
//        self.rightLabel = [UILabel new];
//        [self.rightView addSubview:self.rightLabel];
//        self.rightLabel.textAlignment = NSTextAlignmentCenter;
//        self.rightLabel.font = [UIFont systemFontOfSize:13];
//        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.rightImageView.mas_bottom).with.offset(1);
//            make.centerX.equalTo(self.rightImageView).with.offset(0);
//
//        }];
//        
        self.topShadow = [UIImageView new];
        [self addSubview:self.topShadow];
        self.topShadow.backgroundColor = ME_Color(238, 238, 238);
        [self.topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
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

#pragma mark -
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEHomeRecommendTopCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeRecommendTop" forIndexPath:indexPath];
    cell.dic = ME_DATASOURCE.homeTopArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ME_Width / 4, 70);
}

//item横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//item纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//- (void)setDic:(NSDictionary *)dic
//{
//    _dic = dic;
//    self.leftImageView.image = [UIImage imageNamed:dic[@"activity"]];
//    self.centLeftImageView.image = [UIImage imageNamed:dic[@"rank"]];
//    self.centRightImageView.image = [UIImage imageNamed:dic[@"channel"]];
//    self.rightImageView.image = [UIImage imageNamed:dic[@"mission"]];
//    
//    self.leftLabel.text = dic[@"activity_title"];
//    self.centLeftLabel.text = dic[@"rank_title"];
//    self.centRightLabel.text = dic[@"channel_title"];
//    self.rightLabel.text = dic[@"mission_title"];
//}

@end
