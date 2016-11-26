//
//  MEChannelTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/9.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEChannelTableViewCell.h"
#import "MEHeader.h"
#import "MEChannelCollectionViewCell.h"

@interface MEChannelTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView * collectionView;

@end

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
        self.collectionView.scrollEnabled = NO;
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
        }];
        [self.collectionView registerClass:[MEChannelCollectionViewCell class] forCellWithReuseIdentifier:@"Channel"];
        
        UIImageView * downShadow = [UIImageView new];
        [self addSubview:downShadow];
        downShadow.backgroundColor = ME_Color(238, 238, 238);//229, 230, 230
        [downShadow mas_makeConstraints:^(MASConstraintMaker *make) {
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
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEChannelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Channel" forIndexPath:indexPath];
    cell.dic = self.array[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ME_Width / 2, 155);
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

//- (void)setArray:(NSArray *)array
//{
//    _array = array;
//    self.leftThemesImageView.image = [UIImage imageNamed:array[0][@"themes_image"]];
//    self.rightThemesImageView.image = [UIImage imageNamed:array[1][@"themes_image"]];
//    
//    self.leftTitleLabel.text = array[0][@"title"];
//    self.rightTitleLabel.text = array[1][@"title"];
//    
//    self.leftPlayedLabel.text = array[0][@"played_count"];
//    self.rightPlayedLabel.text = array[1][@"played_count"];
//
//}

@end
