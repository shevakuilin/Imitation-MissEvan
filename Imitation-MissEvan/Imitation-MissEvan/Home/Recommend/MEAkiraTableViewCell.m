//
//  MEAkiraTableViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/13.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEAkiraTableViewCell.h"
#import "MEHeader.h"
#import "MEAkiraCollectionViewCell.h"

@interface MEAkiraTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView * collectionView;

@end

@implementation MEAkiraTableViewCell

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
        self.backgroundColor = [UIColor clearColor];//ME_Color(250, 250, 250);
        
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //创建collectionView 通过一个布局策略layout来创建
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        [self addSubview:self.collectionView];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor clearColor];//ME_Color(250, 250, 250);
        self.collectionView.scrollEnabled = NO;
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
        }];
        [self.collectionView registerClass:[MEAkiraCollectionViewCell class] forCellWithReuseIdentifier:@"Akira"];
        
//        UIImageView * topShadow = [UIImageView new];
        [self addSubview:self.topShadow];
//        topShadow.backgroundColor = ME_Color(238, 238, 238);
        [self.topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
        }];
        
//        UIImageView * downShadow = [UIImageView new];
//        [self addSubview:downShadow];
//        downShadow.backgroundColor = ME_Color(238, 238, 238);//229, 230, 230
//        [downShadow mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self).with.offset(0);
//            
//            make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
//        }];

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
    MEAkiraCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Akira" forIndexPath:indexPath];
    cell.dic = ME_DATASOURCE.akiraArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ME_Width / 4, 108);
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
