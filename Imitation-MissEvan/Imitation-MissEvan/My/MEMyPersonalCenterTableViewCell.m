//
//  MEMyPersonalCenterTableViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/30.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEMyPersonalCenterTableViewCell.h"
#import "MEHeader.h"
#import "MEMyPersonalCenterCollectionViewCell.h"

@interface MEMyPersonalCenterTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView * collectionView;

@end

@implementation MEMyPersonalCenterTableViewCell

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

            [self addSubview:self.titleLabel];
            self.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(10);
                make.top.equalTo(self).with.offset(11);
            }];
            

            [self addSubview:self.topShadow];
            [self.topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
            }];
            

            [self addSubview:self.downShadow];
            [self.downShadow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
            }];
            
            //创建一个layout布局类
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
            //设置布局方向为垂直流布局
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            //创建collectionView 通过一个布局策略layout来创建
            self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];            [self addSubview:self.collectionView];
            self.collectionView.backgroundColor = [UIColor clearColor];//[UIColor whiteColor];
            [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLabel.mas_bottom).with.offset(9);
                make.left.equalTo(self).with.offset(0);
                make.right.equalTo(self).with.offset(0);
                make.bottom.equalTo(self).with.offset(-1);
            }];
            self.collectionView.delegate = self;
            self.collectionView.dataSource = self;
            [self.collectionView registerClass:[MEMyPersonalCenterCollectionViewCell class] forCellWithReuseIdentifier:@"MyPersonalCenter"];

        }
    }
    return self;
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    [self.collectionView reloadData];//这里一定要记得刷新collectionView，否则切图将无法跟随主题刷新
}

#pragma mark -
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.array.count == 2) {
        return 4;
    }
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEMyPersonalCenterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyPersonalCenter" forIndexPath:indexPath];
    if (self.array.count == 2) {
        self.titleLabel.text = @"我的消息";
        if (indexPath.row < 2) {
            cell.classifyImageView.hidden = NO;
            cell.classifyLabel.hidden = NO;
            cell.dic = self.array[indexPath.row];
        } else {
            cell.classifyImageView.hidden = YES;
            cell.classifyLabel.hidden = YES;
        }
    } else {
        cell.dic = self.array[indexPath.row];
        self.titleLabel.text = @"个人中心";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * row = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    if ([self.delegate respondsToSelector:@selector(classViewCell: didSelectWithItem:)]) {
        [self.delegate classViewCell:self didSelectWithItem:row];
    }
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ME_Width / 4, 90);
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

@end
